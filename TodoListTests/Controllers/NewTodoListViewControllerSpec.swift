import Quick
import Nimble
@testable import TodoList

extension UIControl {
    func tap() {
        self.sendActions(for: .touchUpInside)
    }
}

class NewTodoListViewControllerSpec: QuickSpec {
    override func spec() {
        var newTodoListViewController: NewTodoListViewController!
        let parentViewController = UIViewController()
        
        beforeEach() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            newTodoListViewController = storyboard.instantiateViewController(withIdentifier: "NewTodoListViewController") as! NewTodoListViewController

            guard let window = UIApplication.shared.keyWindow else { fail(); return }
            window.rootViewController = parentViewController
            RunLoop.main.run(until: Date())

            parentViewController.present(newTodoListViewController, animated: false, completion: nil)
            
            expect(parentViewController.presentedViewController).notTo(beNil())
        }
        
        describe("when the user taps 'Create'") {
            beforeEach() {
                guard let newTodoListTextField = newTodoListViewController.newTodoListView.newTodoListTextField else { fail(); return }
                newTodoListTextField.text = "A Todo List"
                
                guard let createTodoListButton = newTodoListViewController.newTodoListView.createTodoListButton else { fail(); return }
                createTodoListButton.tap()
            }
            
            it("dismisses itself") {
                expect(parentViewController.presentedViewController).toEventually(beNil())
            }
        }
    }
}
