import UIKit

class TodoListsViewController: UIViewController {
    var todoListsView: TodoListsView { return view as! TodoListsView }
    var todoListDataSourceDelegate: TodoListDataSourceDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tableView = todoListsView.tableView {
            todoListDataSourceDelegate = TodoListDataSourceDelegate(tableView: tableView,
                                                                    repo: InMemoryTodoListRepository.shared,
                                                                    asyncHelper: Async())
            if let delegate = todoListDataSourceDelegate {
                tableView.dataSource = delegate
                tableView.delegate = delegate
                delegate.displayTodoLists()
            }
        }
    }
    
    @IBAction func addTodoListButtonTapped() {
        performSegue(withIdentifier: "PresentNewTodoListViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newTodoListViewController = segue.destination as? NewTodoListViewController {
            newTodoListViewController.delegate = self
        }
    }
    
}

extension TodoListsViewController: NewTodoListViewControllerDelegate {
    func todoListCreated() {
        if let delegate = todoListDataSourceDelegate {
            delegate.displayTodoLists()
        }
        self.dismiss(animated: true) {}
    }
}
