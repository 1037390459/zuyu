//
//  LMNotificationController.swift
//  ZuYu2
//
//  Created by million on 2020/8/20.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

enum NotificationType : Int {
    case all
    case read
    case unread
    case duration
}

class LMNotificationController: UIViewController {
    
    var type : NotificationType? {
        willSet(newType) {
            if newType != type {
                switch newType {
                case .all, .read, .unread, .duration:
                    allBtn.isSelected = newType == .all
                    readBtn.isSelected = newType == .read
                    unreadBtn.isSelected = newType == .unread
                    durationBtn.isSelected = newType == .duration
                    let index = newType?.rawValue ?? 0
                    contentView.removeSubviews()
                    let toView = children[index].view!
                    toView.frame = contentView.bounds
                    contentView.addSubview(toView)
                    break
                default:
                    break
                }
            }
        }
    }
    
    
    lazy var stackView : UIStackView = {
        let stackView = UIStackView.init()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.widthAnchor.constraint(equalToConstant: screenWidth * 0.8).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        stackView.addArrangedSubview(allBtn)
        stackView.addArrangedSubview(unreadBtn)
        stackView.addArrangedSubview(readBtn)
        stackView.addArrangedSubview(durationBtn)
        return stackView
    }()
    
    lazy var allBtn : UIButton = {
        let button = IndicatorButton.init(type: .custom)
        button.addTarget(self, action: #selector(LMNotificationController.allBtnTapped(_:)), for: .touchUpInside)
        button.bottomLayerEnabled = true
        button.setTitleForAllStates("全部")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(Constant.Color.lightPrimaryDark, for: .normal)
        button.setTitleColor(Constant.Color.primary, for: .selected)
        button.bottomLayerColor = Constant.Color.primary
        return button
    }()
    
    lazy var unreadBtn : UIButton = {
        let button = IndicatorButton.init(type: .custom)
        button.addTarget(self, action: #selector(LMNotificationController.unreadBtnTapped(_:)), for: .touchUpInside)
        button.bottomLayerEnabled = true
        button.setTitleForAllStates("未读")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(Constant.Color.lightPrimaryDark, for: .normal)
        button.setTitleColor(Constant.Color.primary, for: .selected)
        button.bottomLayerColor = Constant.Color.primary
        return button
    }()
    
    lazy var readBtn : UIButton = {
        let button = IndicatorButton.init(type: .custom)
        button.addTarget(self, action: #selector(LMNotificationController.readBtnTapped(_:)), for: .touchUpInside)
        button.bottomLayerEnabled = true
        button.setTitleForAllStates("已读")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(Constant.Color.lightPrimaryDark, for: .normal)
        button.setTitleColor(Constant.Color.primary, for: .selected)
        button.bottomLayerColor = Constant.Color.primary
        return button
    }()
    
    lazy var durationBtn : UIButton = {
        let button = IndicatorButton.init(type: .custom)
        button.addTarget(self, action: #selector(LMNotificationController.durationBtnTapped(_:)), for: .touchUpInside)
        button.bottomLayerEnabled = true
        button.setTitleForAllStates("时段")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(Constant.Color.lightPrimaryDark, for: .normal)
        button.setTitleColor(Constant.Color.primary, for: .selected)
        button.bottomLayerColor = Constant.Color.primary
        return button
    }()
    
    lazy var contentView : UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = stackView
        let vc1 = LMNotiTableController()
        vc1.type = .all
        addChild(vc1)
              
        let vc2 = LMNotiTableController()
        vc2.type = .unread
        addChild(vc2)
              
        let vc3 = LMNotiTableController()
        vc3.type = .read
        addChild(vc3)
        
        let vc4 = LMNotiTableController()
        vc4.type = .duration
        addChild(vc4)
        
        type = .all
    }
    
    @objc func allBtnTapped(_ sender :UIButton ) {
        type = .all
    }
    
    @objc func readBtnTapped(_ sender :UIButton ) {
        type = .read
    }
    
    @objc func unreadBtnTapped(_ sender :UIButton ) {
        type = .unread
    }
    
    @objc func durationBtnTapped(_ sender :UIButton ) {
        type = .duration
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
