import UIKit
private var maxLengths = [UITextField: Int]()
extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            guard let length = maxLengths[self] else {
                return Int.max}
            return length}
        set {
            maxLengths[self] = newValue
            addTarget(
                self,
                action: #selector(limitLength),
                for: UIControl.Event.editingChanged)
        }
    }
    
    @objc func limitLength(textField: UITextField) {
        guard let the_text = textField.text,
              the_text.count > maxLength
        else {
            return
        }
        let selection = selectedTextRange
        let maxCharIndex = the_text.index(the_text.startIndex, offsetBy: maxLength)
        text = the_text.substring(to: maxCharIndex)
        selectedTextRange = selection
    }
    
}
