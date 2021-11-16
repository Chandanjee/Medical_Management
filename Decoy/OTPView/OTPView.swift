//
//  OTPView.swift
//  Decoy
//
//  Created by MAC on 10/11/21.
//

import UIKit

class OTPView: UIView {

    @IBOutlet weak var lblNumberTitle:UILabel!
    @IBOutlet weak var viewOtps:UIView!
    @IBOutlet weak var btnVariefy:UIButton!
    @IBOutlet weak var btnClose:UIButton!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        commonInit()
    }

    func commonInit(){
        
    }
}
