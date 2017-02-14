import UIKit

protocol NewTodoListViewControllerDelegate {
    func todoListCreated()
}

class NewTodoListViewController: UIViewController {
    var newTodoListView: NewTodoListView { return view as! NewTodoListView }
    let todoListRepository = InMemoryTodoListRepository.shared
    var delegate: NewTodoListViewControllerDelegate?
    
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
        if let delegate = delegate {
            delegate.todoListCreated()
        }
    }
}
