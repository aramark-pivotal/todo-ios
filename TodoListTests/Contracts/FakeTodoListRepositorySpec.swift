import Quick
import Nimble

class FakeTodoListRepositorySpec: TodoListRepositorySpec {
    override func spec() {
        repository = FakeTodoListRepository.shared
        super.spec()
    }
}
