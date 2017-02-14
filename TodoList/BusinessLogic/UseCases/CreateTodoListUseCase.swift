protocol CreateTodoListObserver {
    func invalidTodoList()
    func todoListCreated(todoList: String)
}

class CreateTodoListUseCase: UseCase {
    let name: String
    let observer: CreateTodoListObserver
    let repository: TodoListRepository
    
    init(name: String, observer: CreateTodoListObserver, repo repository: TodoListRepository) {
        self.name = name
        self.observer = observer
        self.repository = repository
    }

    func execute() {
        if (name == "") {
            observer.invalidTodoList()
        } else {
            repository.save(todoList: name, completion: { (todoList: String) in
                observer.todoListCreated(todoList: todoList)
            })
        }
    }
}
