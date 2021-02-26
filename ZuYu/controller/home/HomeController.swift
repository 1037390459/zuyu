//
//  HomeController.swift
//  ZuYu
//
//  Created by million on 2020/7/12.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import SwifterSwift
import SVProgressHUD
import RxSwift
import MJRefresh

class HomeController: UIViewController {
    
    private let cellIdOrNibName = ShopCell.className
    
    @IBOutlet weak var filterBtn: UIButton!
    
    @IBOutlet weak var conditionStackView: UIStackView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var locateBtn : ExtraImageButton!
    
    var location : CLLocation?
    
    var city : String?
    
    var sortFlag = 1
    
    var pageNo = 1
    
    var pageSize = 10
    
    let disposeBag = DisposeBag()
    
    var mData : [StoreList.Store] = []
    
    lazy var locationManager : AMapLocationManager = {
        var manager = AMapLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.locationTimeout = 6
        manager.reGeocodeTimeout = 3
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        checkLocatePermisson(controller: self)
        locateBtn.setTitle("定位中", for: .normal)
        locationManager.requestLocation(withReGeocode: true) {[weak self] (location, reGeoCode, error) in
            guard let self = self else {
                return
            }
            guard error == nil else {
                self.view.makeToast("error:" + error.debugDescription)
                self.locateBtn.setTitle("定位失败", for: .normal)
                return
            }
            self.location = location
            if let city = reGeoCode?.city {
                self.city = city
                self.locateBtn.setTitle(city, for: .normal)
                self.storeListApi()
            }
            print("geo:\(String(describing: reGeoCode))")
        }
    }
    
    func setUpUI() {
        initNavigationItem()
        initTable()
        if let firstItem = conditionStackView.arrangedSubviews.first as? UIButton {
            firstItem.isSelected = true
        }
        conditionStackView.isHidden = true
        filterBtn.addTarget(self, action: #selector(HomeController.toggleCondition), for: .touchUpInside)
    }
    
    func initNavigationItem() {
        let arrowImg = UIImage.init(named: "right_arrow")
        let arrowImgV = UIImageView.init(image: arrowImg)
        locateBtn = ExtraImageButton.init(type: .custom)
        locateBtn.extraImageView = arrowImgV
        locateBtn.setImage(UIImage.init(named: "locate"), for: .normal)
        locateBtn.setTitle("深圳市", for: .normal)
        locateBtn.titleLabel?.font = Constant.Font.normal
        locateBtn.setTitleColor(UIColor.black, for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: locateBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "search"), style: .plain, target: self, action: #selector(HomeController.search))
    }
    
    private func initTable() {
        tableView.register(UINib.init(nibName: cellIdOrNibName, bundle: nil), forCellReuseIdentifier: cellIdOrNibName)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        tableView.separatorStyle = .none
        let mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            [weak self] in
            print("refreshing header")
            self?.pageNo = 1
            self?.storeListApi()
        })
        mj_header.lastUpdatedTimeLabel?.isHidden = true
        tableView.mj_header = mj_header
        
        let mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            [weak self] in
            print("refreshing footer")
            self?.pageNo += 1
            self?.storeListApi()
        })
        tableView.mj_footer = mj_footer
    }
    
    @objc private func search() {
        let vc = CitySelectorViewController.init()
        vc.delegate = self
        navigationController?.pushViewController(vc)
    }
    
    @objc private func toggleCondition() {
        conditionStackView.isHidden = !conditionStackView.isHidden
        filterBtn.isSelected = !filterBtn.isSelected
    }
    
    @IBAction func filterByCondition(_ sender: UIButton) {
        guard let index = conditionStackView.arrangedSubviews.firstIndex(of: sender) else {
            return
        }
        for view in conditionStackView.arrangedSubviews {
            if let button = view as? UIButton {
                button.isSelected = false
            }
        }
        sender.isSelected = !sender.isSelected
        sortFlag = index + 1
        toggleCondition()
        storeListApi()
    }
    
    private func storeListApi() {
        let lat = location?.coordinate.latitude
        let lng = location?.coordinate.longitude
        var params : [String : Any] = [:]
        params["keyWord"] = ""
        params["lat"] = lat
        params["lng"] = lng
        params["pageNum"] = pageNo
        params["pageSize"] = pageSize
        params["sortFlag"] = sortFlag
        NetManager.request(.list(params), entity: StoreList.self)
            .subscribe(onNext: { [weak self] (result) in
                guard let self = self else {
                    return
                }
                if self.pageNo == 1 {
                    self.mData.removeAll()
                }
                self.mData.append(contentsOf: result.records ?? [])
                self.tableView.mj_header!.endRefreshing()
                self.tableView.mj_footer!.endRefreshing()
                if let total = result.total, self.mData.count == total {
                    self.tableView.mj_footer!.endRefreshingWithNoMoreData()
                }
                self.tableView.reloadData()
                print("result:\(result)")
            }, onError: { (e) in
                SVProgressHUD.showError(withStatus: e.localizedDescription)
            }).disposed(by: disposeBag)
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

extension HomeController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdOrNibName, for: indexPath) as! ShopCell
        cell.model = mData[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

extension HomeController : AMapLocationManagerDelegate {
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!) {
        print("amapLocationManager")
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        print("error\(error.localizedDescription)")
        view.makeToast(error.localizedDescription)
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, doRequireLocationAuth locationManager: CLLocationManager!) {
        locationManager.requestAlwaysAuthorization()
    }
}

extension HomeController : CityDidSelectedDelegate {
    func didSelected(citySelector: CitySelectorViewController?, city: String?) {
        navigationController?.popViewController(animated: true, nil)
        locateBtn.setTitle(city, for: .normal)
        locateBtn.sizeToFit()
    }
}

