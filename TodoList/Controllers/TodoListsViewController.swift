import UIKit

class TodoListsViewController: UIViewController {
    var todoListsView: TodoListsView { return view as! TodoListsView }
    var todoLists: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTodoLists()
    }
    
    @IBAction func addTodoListButtonTapped() {
        performSegue(withIdentifier: "PresentNewTodoListViewController", sender: nil)
    }
    
    func displayTodoLists() {
        InMemoryTodoListRepository.shared.getTodoLists() { (todoLists: [String]) in
            self.todoLists = todoLists
            DispatchQueue.main.async {
                guard let tableView = self.todoListsView.tableView else { return }
                tableView.reloadData()
            }
        }
    }
    
}

extension TodoListsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
    }
}

extension TodoListsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let todoListCell = cell as? TodoListCell {
            if let nameLabel = todoListCell.nameLabel {
                nameLabel.text = todoLists[indexPath.row]
            }
        }
    }
}
