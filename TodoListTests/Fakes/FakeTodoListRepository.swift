@testable import TodoList

class FakeTodoListRepository: TodoListRepository {
    static let shared = FakeTodoListRepository()
    
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
