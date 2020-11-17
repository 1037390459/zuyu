//
//  RoleController.swift
//  ZuYu2
//
//  Created by million on 2020/8/5.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class RoleController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var backgroundView: UIView!
    
    var onCancelClosure : (() -> Void)?
    
    var onItemTapped : ((_ index : Int?) -> Void)?
    
    fileprivate var textColor : UIColor? = nil
    
    fileprivate var backgroundColor : UIColor? = nil
    
    fileprivate var borderColor : UIColor? = nil
    
    var type : ClientType? {
        didSet {
            switch type {
            case .jishi:
                textColor = UIColor.init(hexString: "#FE738D")
                backgroundColor = UIColor.init(hexString: "#FE738D", transparency: 0.1)
                borderColor = UIColor.init(hexString: "#FE738D")
                break
            case .gudong, .loumian:
                textColor = UIColor.init(hexString: "#008CFF")
                backgroundColor = UIColor.init(hexString: "#008CFF", transparency: 0.1)
                borderColor = UIColor.init(hexString: "#008CFF")
                break
            default:
                break
            }
        }
    }
    
    var clientTypes : [ClientType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.backgroundColor = .clear
        clientTypes.append(.qiehuan)
        for view in stackView.arrangedSubviews {
            let index = stackView.arrangedSubviews.firstIndex(of: view)
            let types : [ClientType] = [.gudong, .loumian, .jishi, .qiehuan]
            view.isHidden = !clientTypes.contains(types[index!])
            if let btn = view as? UIButton {
                btn.setTitleColor(textColor, for: .normal)
                btn.backgroundColor = backgroundColor
                btn.borderColor = borderColor
            }
        }
        cancelBtn.setTitleColor(textColor, for: .normal)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(RoleController.dismiss(_:)))
        backgroundView.addGestureRecognizer(tap)
    }

    @objc func dismiss(_ gesture : UIGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        onCancelClosure?()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if let btn = sender as? UIButton {
           let index = stackView.arrangedSubviews.firstIndex(of: btn)
            onItemTapped?(index)
        }
        dismiss(animated: true, completion: nil)
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
