import Quick
import Nimble
@testable import TodoList

class FetchAllTodoListsObserverSpy: FetchAllTodoListsObserver {
    var fetchedTodoLists: [String]? = nil

    func fetched(todoLists: [String]) {
        fetchedTodoLists = todoLists
    }

    func reset() {
        fetchedTodoLists = nil
    }

}

class FetchAllTodoListsUseCaseSpec: QuickSpec {
    override func spec() {
        describe("FetchAllTodoListsUseCase") {
            let observerSpy = FetchAllTodoListsObserverSpy()
            let fakeRepository = FakeTodoListRepository()

            beforeEach() {
                observerSpy.reset()
            }

            context("when there are no todo lists") {
                it("notifies its observer with an empty array") {
                    waitUntil { done in
                        FetchAllTodoListsUseCase(observer: observerSpy, repo: fakeRepository).execute()

                        if let fetchedTodoLists = observerSpy.fetchedTodoLists {
                            expect(fetchedTodoLists).to(equal([]))
                            done()
                        } else {
                            fail("Expected fetchedTodoLists not to be nil")
                            done()
                        }
                    }
                }
            }

            context("when there are todo lists") {
                it("notifies its observer with the todo lists") {
                    waitUntil { done in
                        fakeRepository.save(todoList: "A todo list") { (todoList: String) in
                            FetchAllTodoListsUseCase(observer: observerSpy, repo: fakeRepository).execute()

                            if let fetchedTodoLists = observerSpy.fetchedTodoLists {
                                expect(fetchedTodoLists).to(equal(["A todo list"]))
                                done()
                            } else {
                                fail("Expected fetchedTodoLists not to be nil")
                                done()
                            }
                        }
                    }
                }
            }
        }
    }
}
