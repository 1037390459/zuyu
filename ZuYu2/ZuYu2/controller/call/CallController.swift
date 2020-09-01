//
//  CallController.swift
//  ZuYu2
//
//  Created by million on 2020/8/3.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

enum ServiceType : Int {
    case main
    case sub
}

class CallController: UIViewController {
    
    let cellIdOrNibName = CallCell.className
    
    @IBOutlet weak var tableView: UITableView!
    
    /// 呼叫服务员
    @IBOutlet weak var callBtn: UIButton!
    
    var type : ServiceType? {
        willSet(newType) {
            if newType != type {
                switch newType {
                       case .main:
                           leftBtn.isSelected = true
                           rightBtn.isSelected = false
                           tableView.reloadData()
                           break
                       case .sub:
                           leftBtn.isSelected = false
                           rightBtn.isSelected = true
                           tableView.reloadData()
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
        stackView.addArrangedSubview(rightBtn)
        return stackView
    }()
    
    lazy var leftBtn : UIButton = {
        let button = IndicatorButton.init(type: .custom)
        button.addTarget(self, action: #selector(CallController.leftBtnTapped(_:)), for: .touchUpInside)
        button.bottomLayerEnabled = true
        button.setTitleForAllStates("主项服务")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(Constant.Color.lightPrimaryDark, for: .normal)
        button.setTitleColor(Constant.Color.jishiPrimary, for: .selected)
        return button
    }()

    lazy var rightBtn : UIButton = {
         let button = IndicatorButton.init(type: .custom)
         button.addTarget(self, action: #selector(CallController.rightBtnTapped(_:)), for: .touchUpInside)
         button.bottomLayerEnabled = true
         button.setTitleForAllStates("副项安排")
         button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
         button.setTitleColor(Constant.Color.lightPrimaryDark, for: .normal)
         button.setTitleColor(Constant.Color.jishiPrimary, for: .selected)
         return button
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    let callBtnLayer = Constant.Layer.gradientLayer2()
    
    func setUpUI()  {
        initNavigationItem()
        callBtn.setupButtonImageAndTitlePossitionWith(padding: 6, style: .imageIsLeft)
        callBtn.layer.insertSublayer(callBtnLayer, at: 0)
        tableView.register(UINib.init(nibName: cellIdOrNibName, bundle: nil), forCellReuseIdentifier: cellIdOrNibName)
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func initNavigationItem() {
        type = .main
        navigationItem.titleView = stackView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        callBtnLayer.frame = callBtn.bounds
    }
    
    @objc func leftBtnTapped(_ sender :UIButton ) {
        type = .main
    }
    
    @objc func rightBtnTapped(_ sender :UIButton ) {
        type = .sub
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

extension CallController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdOrNibName) as! CallCell
        cell.type = type
        cell.selectionStyle = .none
        cell.callClosure = {
            [weak self] in
            self?.callService()
        }
        cell.typeClosure = {
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func callService()  {
        let alertVc = UIAlertController.init(title: "提示", message: "确认呼叫(\("修脚"))技师嘛？", preferredStyle: .alert)
        alertVc.view.tintColor = Constant.Color.jishiPrimary
        let cancelAction = UIAlertAction.init(title: "取消", style: .default, handler: nil)
        cancelAction.setValue(Constant.Color.lightPrimaryDark, forKey: "titleTextColor")
        let sureAction = UIAlertAction.init(title: "确定", style: .destructive) { (_) in
            
        }
        alertVc.addAction(cancelAction)
        alertVc.addAction(sureAction)
        present(alertVc, animated: true, completion: {
            alertVc.view.superview?.isUserInteractionEnabled = true
            alertVc.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        })
    }
    
    @objc func dismissOnTapOutside(){
       dismiss(animated: true, completion: nil)
    }
}
