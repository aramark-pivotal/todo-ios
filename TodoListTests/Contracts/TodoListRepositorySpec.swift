import Quick
import Nimble
@testable import TodoList

class TodoListRepositorySpec: QuickSpec {
    var repository: TodoListRepository?
    
    override func spec() {
        guard let repository = repository else { return }
        
        afterEach {
            repository.reset()
        }
        
        describe("save") {
            it("saves the todo list and returns the saved todo list in its callback") {
                let todoList = "My Todo List"
                
                waitUntil { done in
                    repository.save(todoList: todoList) { (todoList: String) in
                        expect(todoList).to(equal("My Todo List"))
                        done()
                    }
                }
            }
        }
        
        describe("getTodoLists") {
            context("when there are no saved todo lists") {
                it("returns an empty list to its completion") {
                    waitUntil { done in
                        repository.getTodoLists() { (todoLists: [String]) in
                            expect(todoLists).to(equal([]))
                            done()
                        }
                    }
                }
            }
            
            context("when there are saved todo lists") {
                it("returns the saved todo lists to its completion") {
                    waitUntil { done in
                        repository.save(todoList: "A saved todo list") { (todoList: String) in
                            repository.getTodoLists() { (todoLists: [String]) in
                                expect(todoLists).to(equal([todoList]))
                                done()
                            }
                        }
                    }

                }
            }
        }
    }
}
