//
//  LMHomeController.swift
//  ZuYu2
//
//  Created by million on 2020/8/19.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import RxSwift

class LMHomeController: UIViewController {
    
    let cellIdOrNibName = LMHomeCell.className
    
    let headerIdOrNibName = LMHomeHeader.className
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let disposeBag = DisposeBag()
    
    var achievementsBean : AchievementsBean?
    
    lazy var mTitleLbl = { () -> UILabel in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        lbl.textColor = UIColor.white
        lbl.text = "部长:肖申克"
        return lbl
    }()
    
    lazy var mSubTitleLbl = { () -> UILabel in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        lbl.textColor = UIColor.white
        lbl.text = "工位到期:2020-05-08》"
        return lbl
    }()
    
    
    func setUpTitleView() {
        let mTitleView = UIView.init()
        mTitleView.translatesAutoresizingMaskIntoConstraints = false
        mTitleView.addSubview(mTitleLbl)
        mTitleView.addSubview(mSubTitleLbl)
        mTitleLbl.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        mTitleLbl.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        mSubTitleLbl.setContentHuggingPriority(.defaultLow, for: .horizontal)
        mSubTitleLbl.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        NSLayoutConstraint.activate([
            mTitleLbl.centerYAnchor.constraint(equalTo: mTitleView.centerYAnchor),
            mTitleLbl.leadingAnchor.constraint(equalTo: mTitleView.leadingAnchor, constant: 0),
            mSubTitleLbl.bottomAnchor.constraint(equalTo: mTitleLbl.bottomAnchor),
            mSubTitleLbl.leadingAnchor.constraint(equalTo: mTitleLbl.trailingAnchor, constant: 6),
            mSubTitleLbl.trailingAnchor.constraint(equalTo: mTitleView.trailingAnchor, constant: -5),
        ])
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: mTitleView)
    }
    
    lazy var bgView = { ()-> UIView in
        let bgView = UIView()
        bgView.addSubview(bgImgV)
        bgView.addSubview(roundView)
        return bgView
    }()
    
    lazy var bgImgV = { ()->UIImageView in
        let bgImgV = UIImageView()
        bgImgV.image = UIImage.init(named: "bj1")
        return bgImgV
    }()
    
    lazy var roundView = { ()->UIView in
        let roundView = UIView()
        roundView.backgroundColor = UIColor.white
        return roundView
    }()
    
    lazy var mData = [
        ["icon" : "fjzhuangtai", "desc" : "房间状态", "action" : "room"],
        ["icon" : "jszhuangtai", "desc" : "技师状态", "action" : "workerstatuslist"],
        ["icon" : "wdyeji", "desc" : "我的业绩", "action" : "performancelist"],
        ["icon" : "wdkaoqin", "desc" : "我的考勤", "action" : "mychecklist"],
        
        ["icon" : "hyguanli", "desc" : "会员管理", "action" : "viplist"],
        ["icon" : "yyguanli", "desc" : "预约管理", "action" : "workerreservelist"],
        ["icon" : "xfqingdan", "desc" : "消费清单", "action" : "orderslist"],
        ["icon" : "ygyeji", "desc" : "员工业绩", "action" : "employeeyjlist"],
        
        ["icon" : "mdyeji", "desc" : "门店业绩", "action" : "shopyjlist"],
        ["icon" : "mdkaoqin", "desc" : "门店考勤", "action" : "checkinginlist"],
        ["icon" : "ckdengwei", "desc" : "查看等位", "action" : "waitinglist"],
        ["icon" : "djchaxun", "desc" : "单据查询", "action" : "billsquerylist"],
        
        ["icon" : "jcshuju", "desc" : "基础数据", "action" : "basedatamenu"],
        ["icon" : "spguanli", "desc" : "手牌管理", "action" : "handcardlist"],
        ["icon" : "ygguanli", "desc" : "员工管理", "action" : "employeelist"],
        ["icon" : "khcunchu", "desc" : "客户存储", "action" : "storelist"],
        
        ["icon" : "tpguanli", "desc" : "头牌管理", "action" : "toplist"],
        ["icon" : "cwzhichu", "desc" : "财务支出", "action" : "financelist"],
        ["icon" : "dpqianbao", "desc" : "店铺钱包", "action" : "wallet"],
        ["icon" : "yjbaojing", "desc" : "一键报警", "action" : "akeycall"],
        
        ["icon" : "tzxiaoxi", "desc" : "通知消息", "action" : "newlist"],
        ["icon" : "jyfankui", "desc" : "建议反馈", "action" : "feedback"],
    ]
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationItem()
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundView = bgView
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(UINib.init(nibName: cellIdOrNibName, bundle: nil), forCellWithReuseIdentifier: cellIdOrNibName)
        collectionView.register(UINib.init(nibName: headerIdOrNibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdOrNibName)
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        getAchievementsApi()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bgView.frame = collectionView.bounds
        bgImgV.frame = bgView.bounds
        roundView.frame = CGRect.init(x: 0, y: 255, width: bgView.width, height: bgView.height-255)
        roundView.roundCorners([.topLeft, .topRight], radius: 40)
    }
    
    func initNavigationItem()  {
        //全透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        setUpTitleView()
        let xiaoxi = UIBarButtonItem.init(image: UIImage.init(named: "xiaoxi")?.redDotImage().withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(xiaoxi(_:)))
        let qiehuan = UIBarButtonItem.init(image: UIImage.init(named: "qiehuan")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(qiehuan(_:)))
        navigationItem.rightBarButtonItems = [qiehuan, xiaoxi]
    }
    
    func showActionSheet() {
        let vc = RoleController.init(nibName: RoleController.className, bundle: nil)
        vc.type = .loumian
        if let userTypes = UserInfo.sharedInstance().userBean?.userTypes {
            vc.clientTypes = userTypes.map({ (type) -> ClientType in
                return ClientType(rawValue: type)!
            })
        }
        vc.onItemTapped = {
           [weak self] index in
            guard let self = self else {
                return
            }
            if index == 0 {
                self.refreshToken(type: .gudong)
            }
            if index == 1 {
                self.refreshToken(type: .loumian)
            }
            if index == 2 {
                self.refreshToken(type: .jishi)
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
    
    func refreshToken(type : ClientType) {
        NetManager.request(.refreshToken(type.rawValue), entity: UserBean.self).subscribe(onNext: { (result) in
            clientType = type
            }).disposed(by: disposeBag)
    }
    
    func getAchievementsApi()  {
        NetManager.request(.achievements, entity: AchievementsBean.self).subscribe(onNext: { [weak self] (result) in
            guard let self = self else { return }
            print(result)
            self.collectionView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    /// 切换角色
    @objc func qiehuan(_ sender : Any) {
        showActionSheet()
    }
    
    /// 通知
    @objc func xiaoxi(_ sender : Any) {
        performSegue(withIdentifier: LMNotificationController.className, sender: nil)
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

extension LMHomeController :  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 22
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdOrNibName, for: indexPath) as! LMHomeCell
        cell.model = mData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdOrNibName, for: indexPath) as! LMHomeHeader
        headerView.model = achievementsBean
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width
            , height: 255)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = mData[indexPath.row]
        let action = model["action"]
        let vc = WebController.init("\(serverUrl)/qx-floor-app/#/\(action!)")
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc)
    }
    
}
