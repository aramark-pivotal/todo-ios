import Quick
import Nimble
@testable import TodoList

class Sync: AsyncHelper {
    func executeOnMain(completion: @escaping () -> Void) {
        completion()
    }
}

class TodoListDataSourceDelegateSpec: QuickSpec {
    override func spec() {
        describe("TodoListDataSourceDelegate") {
            var tableView: UITableView!
            var delegate: TodoListDataSourceDelegate!
            let fakeRepository = FakeTodoListRepository.shared

            beforeEach() {
                let todoListVC = TodoListsViewController.getInstanceFromStoryboard(name: "Main") as! TodoListsViewController
                tableView = todoListVC.todoListsView.tableView

                delegate = TodoListDataSourceDelegate(tableView: tableView,
                                                      repo: fakeRepository,
                                                      asyncHelper: Sync())

                tableView.dataSource = delegate
                tableView.delegate = delegate
            }

            afterEach {
                fakeRepository.reset()
            }

            describe("rendering the table view") {
                it("renders the cells with the todo lists") {
                    waitUntil { done in
                        fakeRepository.save(todoList: "Todo List 1") { (todoList: String) in
                            fakeRepository.save(todoList: "Todo List 2") { (todoList: String) in
                                delegate.displayTodoLists()

                                tableView.layoutIfNeeded()

                                if let cells = tableView.visibleCells as? [TodoListCell] {
                                    expect(cells.count).to(equal(2))
                                    if (cells.count > 0) {
                                        expect(cells[0].nameLabel!.text!).to(equal("Todo List 1"))
                                        expect(cells[1].nameLabel!.text!).to(equal("Todo List 2"))
                                    } else {
                                        fail("expected two cells")
                                    }
                                }

                                done()
                            }
                        }
                    }
                }
            }
        }
    }
}
