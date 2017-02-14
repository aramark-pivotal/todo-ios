protocol TodoListRepository {
    func save(todoList: String, completion: (String) -> Void)
    func getTodoLists(completion: ([String]) -> Void)
    func reset()
}
