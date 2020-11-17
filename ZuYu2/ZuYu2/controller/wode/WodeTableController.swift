//
//  WodeController.swift
//  ZuYu2
//
//  Created by million on 2020/8/3.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import LLCycleScrollView
import Kingfisher

class WodeTableController: UITableViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var codeLbl: UILabel!
    
    @IBOutlet weak var sigatureLbl: UILabel!
    
    @IBOutlet weak var iconImgV: UIImageView!
    
    @IBOutlet weak var byzs: UILabel!
    
    @IBOutlet weak var wdye: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var vipView: UIView!

    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var cycleView: LLCycleScrollView!
    
    lazy var vipLayer : CALayer = {
        let bgLayer = Constant.Layer.gradientLayer2()
        vipView.layer.insertSublayer(bgLayer, at: 0)
        return bgLayer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //全透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        tableView.separatorStyle = .none
        let cardTap = UITapGestureRecognizer(target: self, action: #selector(tixian))
        cardView.addGestureRecognizer(cardTap)
        initCycleView()
        if let user = getUser() {
            nameLbl.text = user.name
            codeLbl.text = user.empCode
            if let avatar = user.avatar {
                iconImgV.kf.setImage(with: URL(string: avatar), placeholder: Image(named: "touxiang"))
            }
        }
    }
    
    @IBAction func edit(_ sender: Any) {
        performSegue(withIdentifier: ProfileTableViewController.className, sender: nil)
    }
    
    @objc func tixian() {
        let vc = WebController.init("\(serverUrl)/qx-js-app/#/withdrawal")
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc)
    }
    
    func initCycleView() {
        cycleView.autoScroll = true

        cycleView.infiniteLoop = true

        // 等待数据状态显示的占位图
        cycleView.placeHolderImage = UIImage.init(named: "mine_banner")

        // 如果没有数据的时候，使用的封面图
        cycleView.coverImage = UIImage.init(named: "mine_banner")

        // 设置图片显示方式=UIImageView的ContentMode
        cycleView.imageViewContentMode = .scaleToFill

        // 设置滚动方向（ vertical || horizontal ）
        cycleView.scrollDirection = .horizontal

        // 设置当前PageControl的样式 (.none, .system, .fill, .pill, .snake)
        cycleView.customPageControlStyle = .system

        // 非.system的状态下，设置PageControl的tintColor
        cycleView.customPageControlInActiveTintColor = UIColor.red

        // 设置.system系统的UIPageControl当前显示的颜色
        cycleView.pageControlCurrentPageColor = UIColor.white

        // 设置PageControl的位置 (.left, .right 默认为.center)
        cycleView.pageControlPosition = .center
        cycleView.imagePaths = ["mine_banner","mine_banner"]
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           vipLayer.frame = vipView.bounds
       }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    
    // MARK: tableview delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // do nothing
        }
        if indexPath.row == 1 {
            let vc = WebController.init("\(serverUrl)/qx-js-app/#/replacephone")
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc)
        }
        if indexPath.row == 2 {
            let alertVc = UIAlertController(title: "提示", message: "您确定退出登录吗？", preferredStyle: .alert)
            alertVc.view.tintColor = Constant.Color.jishiPrimary
            let cancelAction = UIAlertAction.init(title: "取消", style: .default, handler: nil)
            cancelAction.setValue(Constant.Color.lightPrimaryDark, forKey: "titleTextColor")
            let sureAction = UIAlertAction.init(title: "确定", style: .destructive) { (_) in
                clientType = .qiehuan
            }
            alertVc.addAction(cancelAction)
            alertVc.addAction(sureAction)
            present(alertVc, animated: true, completion: {
                alertVc.view.superview?.isUserInteractionEnabled = true
                alertVc.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
            })
        }
    }
    
    @objc func dismissOnTapOutside(){
       dismiss(animated: true, completion: nil)
    }

}
