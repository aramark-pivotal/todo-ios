import Quick
import Nimble
@testable import TodoList

extension UIControl {
    func tap() {
        self.sendActions(for: .touchUpInside)
    }
}

class NewTodoListViewControllerDelegateSpy: NewTodoListViewControllerDelegate {
    var todoListCreatedWasCalled = false

    func todoListCreated() {
        todoListCreatedWasCalled = true
    }

    func reset() {
        todoListCreatedWasCalled = false
    }
}

extension UIViewController {
    static func storyboardIdentifier() -> String {
        let className = NSStringFromClass(self)
        let classNameComponents = className.characters.split { $0 == "." }.map{ String($0) }
        return classNameComponents[1]
    }

    static func getInstanceFromStoryboard(name: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: self.storyboardIdentifier())
    }
}

class NewTodoListViewControllerSpec: QuickSpec {
    override func spec() {
        var newTodoListViewController: NewTodoListViewController!
        let delegate = NewTodoListViewControllerDelegateSpy()

        beforeEach() {
            delegate.reset()

            newTodoListViewController = NewTodoListViewController.getInstanceFromStoryboard(name: "Main") as! NewTodoListViewController
            newTodoListViewController.delegate = delegate

            guard let window = UIApplication.shared.keyWindow else { fail(); return }
            window.rootViewController = newTodoListViewController
            RunLoop.main.run(until: Date())
        }

        describe("when the user taps 'Create'") {
            beforeEach() {
                guard let newTodoListTextField = newTodoListViewController.newTodoListView.newTodoListTextField else { fail(); return }
                newTodoListTextField.text = "A Todo List"
                
                guard let createTodoListButton = newTodoListViewController.newTodoListView.createTodoListButton else { fail(); return }
                createTodoListButton.tap()
            }

            it("notifies its delegate that a todo list was created") {
                expect(delegate.todoListCreatedWasCalled).to(beTrue())
            }
        }
    }
}
