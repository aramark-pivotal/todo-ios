import UIKit

protocol AsyncHelper {
    func executeOnMain(completion: @escaping () -> Void)
}

class Async: AsyncHelper {
    func executeOnMain(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            completion()
        }
    }
}

class TodoListDataSourceDelegate: NSObject {
    var todoLists: [String] = []
    let tableView: UITableView
    let repository: TodoListRepository
    let asyncHelper: AsyncHelper

    init(tableView: UITableView, repo repository: TodoListRepository, asyncHelper: AsyncHelper) {
        self.tableView = tableView
        self.repository = repository
        self.asyncHelper = asyncHelper
    }

    func displayTodoLists() {
        FetchAllTodoListsUseCase(observer: self, repo: repository).execute()
    }
}

extension TodoListDataSourceDelegate: FetchAllTodoListsObserver {
    func fetched(todoLists: [String]) {
        self.todoLists = todoLists
        asyncHelper.executeOnMain() {
            self.tableView.reloadData()
        }
    }
}

extension TodoListDataSourceDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoLists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
    }
}

extension TodoListDataSourceDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let todoListCell = cell as? TodoListCell {
            if let nameLabel = todoListCell.nameLabel {
                nameLabel.text = todoLists[indexPath.row]
            }
        }
    }
}
