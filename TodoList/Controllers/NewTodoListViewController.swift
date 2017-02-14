import UIKit

class NewTodoListViewController: UIViewController {
    var newTodoListView: NewTodoListView { return view as! NewTodoListView }
    let todoListRepository = InMemoryTodoListRepository.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTodoListView.delegate = self
    }
}

extension NewTodoListViewController: NewTodoListViewDelegate {
    func todoListFormSubmitted(name: String) {
        CreateTodoListUseCase(name: name, observer: self, repo: todoListRepository).execute()
    }
}

extension NewTodoListViewController: CreateTodoListObserver {
    func invalidTodoList() {
        newTodoListView.clear()
    }
    
    func todoListCreated(todoList: String) {
        if let parentNavVC = self.presentingViewController {
            if let navController = parentNavVC as? UINavigationController {
                if let todoListVC = navController.topViewController as? TodoListsViewController {
                    todoListVC.displayTodoLists()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
