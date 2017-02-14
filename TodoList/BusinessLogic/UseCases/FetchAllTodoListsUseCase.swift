protocol FetchAllTodoListsObserver {
    func fetched(todoLists: [String])
}

class FetchAllTodoListsUseCase: UseCase {
    let observer: FetchAllTodoListsObserver
    let repository: TodoListRepository

    init(observer: FetchAllTodoListsObserver, repo repository: TodoListRepository) {
        self.observer = observer
        self.repository = repository
    }

    func execute() {
        repository.getTodoLists() { (todoLists: [String]) in
            observer.fetched(todoLists: todoLists)
        }
    }

}
