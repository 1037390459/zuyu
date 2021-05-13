//
//  YeJiController.swift
//  ZuYu2
//
//  Created by million on 2020/8/3.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit



class YeJiController: UIViewController {
    
    enum YejiType : Int {
        case yeji
        case gongzi
        case paihangban
    }
    
    var type : YejiType? {
        willSet(newType) {
            if newType != type {
                switch newType {
                case .yeji:
                    leftBtn.isSelected = true
                    middleBtn.isSelected = false
                    rightBtn.isSelected = false
                    contentView.removeSubviews()
                    let toView = children[0].view!
                    toView.frame = contentView.bounds
                    contentView.addSubview(toView)
                    break
                case .gongzi:
                    leftBtn.isSelected = false
                    middleBtn.isSelected = true
                    rightBtn.isSelected = false
                    contentView.removeSubviews()
                    let toView = children[1].view!
                    toView.frame = contentView.bounds
                    contentView.addSubview(toView)
                    break
                case .paihangban:
                    leftBtn.isSelected = false
                    middleBtn.isSelected = false
                    rightBtn.isSelected = true
                    contentView.removeSubviews()
                    let toView = children[2].view!
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
        stackView.widthAnchor.constraint(equalToConstant: screenWidth * 0.95).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        stackView.addArrangedSubview(leftBtn)
        stackView.addArrangedSubview(middleBtn)
        stackView.addArrangedSubview(rightBtn)
        return stackView
    }()
    
    lazy var leftBtn : UIButton = {
        let button = IndicatorButton.init(type: .custom)
        button.addTarget(self, action: #selector(YeJiController.leftBtnTapped(_:)), for: .touchUpInside)
        button.bottomLayerEnabled = true
        button.setTitleForAllStates("技师业绩")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(Constant.Color.lightPrimaryDark, for: .normal)
        button.setTitleColor(Constant.Color.jishiPrimary, for: .selected)
        return button
    }()
    
    lazy var middleBtn : UIButton = {
        let button = IndicatorButton.init(type: .custom)
        button.addTarget(self, action: #selector(YeJiController.middleBtnTapped(_:)), for: .touchUpInside)
        button.bottomLayerEnabled = true
        button.setTitleForAllStates("我的工资")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(Constant.Color.lightPrimaryDark, for: .normal)
        button.setTitleColor(Constant.Color.jishiPrimary, for: .selected)
        return button
    }()
    
    lazy var rightBtn : UIButton = {
        let button = IndicatorButton.init(type: .custom)
        button.addTarget(self, action: #selector(YeJiController.rightBtnTapped(_:)), for: .touchUpInside)
        button.bottomLayerEnabled = true
        button.setTitleForAllStates("技师排行榜")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(Constant.Color.lightPrimaryDark, for: .normal)
        button.setTitleColor(Constant.Color.jishiPrimary, for: .selected)
        return button
    }()
    
    lazy var filterBtn : UIButton = {
        let button = IndicatorButton.init(type: .custom)
        button.addTarget(self, action: #selector(YeJiController.rightBtnTapped(_:)), for: .touchUpInside)
        button.bottomLayerEnabled = true
        button.setTitleForAllStates("筛选")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(Constant.Color.lightPrimaryDark, for: .normal)
        button.setTitleColor(Constant.Color.jishiPrimary, for: .selected)
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
        setUpUI()
    }
    
    func setUpUI()  {
        initNavigationItem()
    }
    
    func initNavigationItem() {
        let vc1 = JSYeJiTableController()
        addChild(vc1)
        
        let vc2 = GongZiTableController()
        addChild(vc2)
        
        let vc3 = PaiHangBanTableController()
        addChild(vc3)
        
        type = .yeji
        navigationItem.titleView = stackView
    }
    
    @objc func leftBtnTapped(_ sender :UIButton ) {
        type = .yeji
    }
    
    @objc func middleBtnTapped(_ sender :UIButton ) {
        type = .gongzi
    }
    
    @objc func rightBtnTapped(_ sender :UIButton ) {
        type = .paihangban
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


