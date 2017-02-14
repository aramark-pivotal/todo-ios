import Quick
import Nimble
@testable import TodoList

class InMemoryTodoListRepositorySpec: TodoListRepositorySpec {
    override func spec() {
        repository = InMemoryTodoListRepository.shared
        super.spec()
    }
}
