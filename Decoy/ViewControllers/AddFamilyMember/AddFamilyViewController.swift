//
//  AddFamilyViewController.swift
//  Decoy
//
//  Created by mrigank.sahai on 18/10/21.
//

import UIKit

class AddFamilyViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var nameTxt:UITextField!
    @IBOutlet weak var genderTxt:UITextField!
    @IBOutlet weak var ageTxt:UITextField!
    @IBOutlet weak var mobilenumberTxt:UITextField!
    @IBOutlet weak var submitButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addArrowBtnToTextFields()
        // Do any additional setup after loading the view.
        genderTxt.loadDropdownData(data: ["Select","Male","Female","Others"])

    }
    
    //MARK: Add Arrow on TextField
    fileprivate func addArrowBtnToTextFields() {
        
        let dropDownBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        dropDownBtn.setBackgroundImage(UIImage(named: "fill_downArrow_small.png"), for: UIControl.State.normal) //  downArrow_black arrowtriangle.down.fill, IQButtonBarArrowDown
        genderTxt.rightViewMode = UITextField.ViewMode.always
        genderTxt.rightView = dropDownBtn
       
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
