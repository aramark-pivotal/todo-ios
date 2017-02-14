import Quick
import Nimble
@testable import TodoList

extension UIBarButtonItem {
    func tap() {
        if let target = target {
            let _ = target.perform(action)
        }
    }
}

class TodoListsViewControllerSpec: QuickSpec {
    override func spec() {
        var todoListsViewController: TodoListsViewController!
        var navController: UINavigationController?
        
        beforeEach() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            todoListsViewController = storyboard.instantiateViewController(withIdentifier: "TodoListsViewController") as! TodoListsViewController

            navController = UINavigationController(rootViewController: todoListsViewController!)

            guard let window = UIApplication.shared.keyWindow else { fail(); return }
            window.rootViewController = navController
            RunLoop.main.run(until: Date())
        }
        
        describe("when the user taps the + button") {
            beforeEach() {
                guard let addTodoListButton = todoListsViewController.todoListsView.addTodoListButton else { fail(); return }
                addTodoListButton.tap()
            }
            
            it("presents a NewTodoListViewController") {
                guard let navController = navController else {
                    fail()
                    return
                }
                expect(navController.presentedViewController).to(beAKindOf(NewTodoListViewController.self))
            }
        }
    }
}
