//
//  JiShiController.swift
//  ZuYu2
//
//  Created by million on 2020/8/3.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class JiShiController: UIViewController {
    
    @IBOutlet weak var shadowView1: UIView!
    
    @IBOutlet weak var shadowView2: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    /// 呼叫商品
    @IBOutlet weak var hjspBtn: CustomBgLayerButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        initNavigationItem()
        scrollView.backgroundColor = UIColor.init(hexString: "FCFCFC")
        scrollView.contentInsetAdjustmentBehavior = .never
        shadowView1.addShadow(ofColor: UIColor(red: 0.28, green: 0, blue: 0.05, alpha: 0.06), radius: 16, offset: CGSize.init(width: 0, height: 4), opacity: 1)
        shadowView2.addShadow(ofColor: UIColor(red: 0.28, green: 0, blue: 0.05, alpha: 0.06), radius: 16, offset: CGSize.init(width: 0, height: 4), opacity: 1)
    }
    
    func initNavigationItem()  {
        //全透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "技师:李若禅(0823)"
        let xiaoxi = UIBarButtonItem.init(image: UIImage.init(named: "xiaoxi")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(JiShiController.xiaoxi(_:)))
        let qiehuan = UIBarButtonItem.init(image: UIImage.init(named: "qiehuan")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(JiShiController.qiehuan(_:)))
        navigationItem.rightBarButtonItems = [qiehuan, xiaoxi]
    }
    
    func showActionSheet() {
        let vc = RoleController.init(nibName: RoleController.className, bundle: nil)
        vc.type = .jishi
        vc.onItemTapped = {
            index in
            if index == 0 {
                clientType = .gudong
            }
            if index == 1 {
                clientType = .loumian
            }
            if index == 2 {
                clientType = .jishi
            }
            if index == 3 {
                clientType = .qiehuan
            }
        }
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: {
            vc.backgroundView.backgroundColor = .black
            vc.backgroundView.alpha = 0.1
        })
    }
    
    /// 切换角色
    @objc func qiehuan(_ sender : Any) {
        showActionSheet()
    }
    
    @objc func xiaoxi(_ sender : Any) {
        
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
