//
//  CustomPickerView.swift
//  Decoy
//
//  Created by MAC on 23/11/21.
//

import Foundation
import UIKit


extension UITextField {
    
    /*
     @IBOutlet weak var titleTxt: UITextField!
     use below code in cotroller
     let salutations = ["Select", "Mr.", "Ms.", "Mrs."]
       titleTxt.loadDropdownData(data: salutations) // first method
     print(titleTxt)
     titleTxt.loadDropdownData(salutations, salutations_onSelect) //  2nd method
     func salutations_onSelect(selectedText: String) {
            if selectedText == "" {
                print("Hello World")
            } else if selectedText == "Mr." {
                print("Hello Sir")
            } else {
                print("Hello Madame")
            }
        }}
     */
    func loadDropdownData(data: [String]) {
        self.inputView = CustomPickerView(pickerData: data, dropdownField: self)
    }
 
    func loadDropdownData(data: [String], onSelect selectionHandler : @escaping (_ selectedText: String) -> Void) {
        self.inputView = CustomPickerView(pickerData: data, dropdownField: self, onSelect: selectionHandler)
    }}

class CustomPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
   
    
    
    var pickerData : [String]!
    var pickerTextField : UITextField!
    var selectionHandler : ((_ selectedText: String) -> Void)?
 
    init(pickerData: [String], dropdownField: UITextField) {
        super.init(frame: CGRect.zero)
 
        self.pickerData = pickerData
        self.pickerTextField = dropdownField
 
        self.delegate = self
        self.dataSource = self
 
//        dispatch_async(dispatch_get_main_queue(), {
        DispatchQueue.main.async {
            if pickerData.count > 0 {
                self.pickerTextField.text = self.pickerData[0]
                self.pickerTextField.isEnabled = true
            } else {
                self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        }
//        })
 
        if self.pickerTextField.text != nil
        && self.selectionHandler != nil {
            selectionHandler?(self.pickerTextField.text!)
        }
    }
 
    convenience init(pickerData: [String], dropdownField: UITextField, onSelect selectionHandler : @escaping (_ selectedText: String) -> Void) {
//        self.selectionHandler = selectionHandler
 
        self.init(pickerData: pickerData, dropdownField: dropdownField)
        self.selectionHandler = selectionHandler
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
   
    
    // Sets number of columns in picker view
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }
 
    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
 
    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
 
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row]
 
        if self.pickerTextField.text != nil && self.selectionHandler != nil {
            selectionHandler?(self.pickerTextField.text!)
        }
    }
    
}
