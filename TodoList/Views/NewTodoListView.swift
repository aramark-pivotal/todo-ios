import UIKit

protocol NewTodoListViewDelegate {
    func todoListFormSubmitted(name: String)
}

class NewTodoListView: UIView {
    var delegate: NewTodoListViewDelegate?
    
    @IBOutlet weak var newTodoListTextField: UITextField?
    @IBOutlet weak var createTodoListButton: UIButton?

    @IBAction func createTodoListButtonTapped() {
        guard let newTodoListTextField = newTodoListTextField else { return }
        
        if let delegate = delegate, let text = newTodoListTextField.text {
            delegate.todoListFormSubmitted(name: text)
        }
    }
    
    func clear() {
        guard let newTodoListTextField = newTodoListTextField else { return }
        newTodoListTextField.text = ""
    }

}
