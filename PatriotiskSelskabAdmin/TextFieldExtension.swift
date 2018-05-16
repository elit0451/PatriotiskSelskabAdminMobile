import Foundation
import UIKit

extension UITextField {
    func loadDropdownData(data: [String]) {
        self.inputView = MyPickerView(pickerData: data, dropdownField: self)
    }
}
