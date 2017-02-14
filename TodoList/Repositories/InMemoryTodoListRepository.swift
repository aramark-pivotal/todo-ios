class InMemoryTodoListRepository: TodoListRepository {
    static let shared = InMemoryTodoListRepository()
    
    var todoLists: [String] = []
    
    func save(todoList: String, completion: (String) -> Void) {
        todoLists.append(todoList)
        completion(todoList)
    }
    
    func getTodoLists(completion: ([String]) -> Void) {
        completion(todoLists)
    }
    
    func reset() {
        todoLists = []
    }
}

