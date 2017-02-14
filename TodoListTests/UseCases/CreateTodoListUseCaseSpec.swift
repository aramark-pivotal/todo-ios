import Quick
import Nimble
@testable import TodoList

class CreateTodoListObserverSpy: CreateTodoListObserver {
    var invalidTodoListWasCalled = false
    var todoListCreatedWasCalled = false
    var createdTodoList: String?
    
    func invalidTodoList() {
        invalidTodoListWasCalled = true
    }
    
    func todoListCreated(todoList: String) {
        todoListCreatedWasCalled = true
        createdTodoList = todoList
    }
    
    func reset() {
        invalidTodoListWasCalled = false
        todoListCreatedWasCalled = false
        createdTodoList = nil
    }
}

class CreateTodoListUseCaseSpec: QuickSpec {
    override func spec() {
        describe("CreateTodoListUseCase") {
            let observer = CreateTodoListObserverSpy()
            let fakeRepository = FakeTodoListRepository.shared
            
            beforeEach() {
                observer.reset()
            }
            
            afterEach() {
                fakeRepository.reset()
            }
            
            context("when there is no name") {
                it("notifies the observer of an invalid todo list") {
                    CreateTodoListUseCase(name: "", observer: observer, repo: fakeRepository).execute()
                    
                    expect(observer.invalidTodoListWasCalled).to(beTrue())
                    expect(observer.todoListCreatedWasCalled).to(beFalse())
                }
            }
            
            context("when there is a name") {
                it("notifies the observer that the todo list was created") {
                    CreateTodoListUseCase(name: "My Todo List", observer: observer, repo: fakeRepository).execute()
                    
                    expect(observer.todoListCreatedWasCalled).to(beTrue())
                    expect(observer.invalidTodoListWasCalled).to(beFalse())
                }
                
                it("passes the created todo list to the observer") {
                    CreateTodoListUseCase(name: "My Todo List", observer: observer, repo: fakeRepository).execute()
                    
                    expect(observer.createdTodoList!).to(equal("My Todo List"))
                }
                
                it("saves the todo list in the repository") {
                    CreateTodoListUseCase(name: "My Todo List", observer: observer, repo: fakeRepository).execute()

                    waitUntil { done in
                        fakeRepository.getTodoLists() { (todoLists: [String]) in
                            expect(todoLists).to(contain("My Todo List"))
                            done()
                        }
                    }
                }
            }
        }
    }
}
