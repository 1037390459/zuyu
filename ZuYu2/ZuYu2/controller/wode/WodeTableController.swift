//
//  WodeController.swift
//  ZuYu2
//
//  Created by million on 2020/8/3.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import LLCycleScrollView

class WodeTableController: UITableViewController {
    
    @IBOutlet weak var vipView: UIView!

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
        initCycleView()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
