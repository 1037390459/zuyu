//
//  CallCell.swift
//  ZuYu2
//
//  Created by million on 2020/8/5.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class CallCell: UITableViewCell {
    
    public var type : ServiceType? {
        didSet {
            switch type {
            case .main:
                typeBtn.isHidden = true
                break
            case .sub:
                 typeBtn.isHidden = false
                 break
            default:
                break
            }
        }
    }
    
    public var callClosure : (()->())?
    
    public var typeClosure : (()->())?
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var typeBtn: CustomImagePostionButton!
    
    @IBOutlet weak var callBtn: CustomImagePostionButton!
    
    var model : ProjectBean? {
        didSet {
            nameLbl.text = model?.projectName
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        typeBtn.addTarget(self, action: #selector(CallCell.typeBtnTapped(_:)), for: .touchUpInside)
        callBtn.addTarget(self, action: #selector(callBtnTapped(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func typeBtnTapped(_ sender : UIButton) {
        typeClosure?()
    }
    
    @objc func callBtnTapped(_ sender : UIButton) {
        callClosure?()
    }
}
