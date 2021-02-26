//
//  LocationViewController.swift
//  ZuYu2
//
//  Created by million on 2020/11/5.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import Toast_Swift
import SVProgressHUD

class LocationViewController: UIViewController {
    
    @IBOutlet weak var positionBtn: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var sureBtn: UIButton!
    
    @IBOutlet weak var mapView: MAMapView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var search : AMapSearchAPI!
    
    var myLocation : CLLocationCoordinate2D?
    
    var shopAnnotaion : MAPointAnnotation?
    
    let cellIdOrNibName = PoiCell.className
    
    var poiList : [AMapPOI] = []
    
    var city : String?
    
    var index : Int = 0
    
    var poi : AMapPOI?
    
    var onAddressCallBack : ((AMapPOI)->())?
    
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
        SVProgressHUD.show()
        locationManager.requestLocation(withReGeocode: true) { (location, reGeoCode, error) in
            SVProgressHUD.dismiss()
            guard error == nil else {
                self.view.makeToast("error:" + error.debugDescription)
                return
            }
            if let city = reGeoCode?.city {
                self.city = city
                self.positionBtn.setTitle(city, for: .normal)
            }
           
            self.myLocation = location?.coordinate
            if let coordinate = self.myLocation {
                self.mapView.centerCoordinate = coordinate
                self.poiSearch(coordinate)
            }
            
            print("geo:\(String(describing: reGeoCode))")
        }
    }
    
    func setUpUI() {
        title = "详细位置"
        positionBtn.addTarget(self, action: #selector(selectCity(_:)), for: .touchUpInside)
        sureBtn.addTarget(self, action: #selector(sure(_:)), for: .touchUpInside)
        
        tableView.backgroundColor = UIColor.init(hexString: "#FCFCFC")
        tableView.tableFooterView = UIView.init(frame: .zero)
        tableView.register(UINib.init(nibName: cellIdOrNibName, bundle: nil), forCellReuseIdentifier: cellIdOrNibName)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        
        searchBar.delegate = self
        mapView.zoomLevel = 15
        mapView.showsScale = false
        mapView.showsCompass = false
        mapView.isShowsUserLocation = true
        mapView.delegate = self
        search = AMapSearchAPI()
        search.delegate = self
    }
    
    @objc func selectCity(_ sender : UIButton) {
        let vc = CitySelectorViewController.init()
        vc.delegate = self
        navigationController?.pushViewController(vc)
    }
    
    
    @objc func sure(_ sender : UIButton) {
        if let poi = self.poi {
            onAddressCallBack?(poi)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showMyLocation(_ sender: Any) {
        if let coordinate = myLocation {
            self.mapView.centerCoordinate = coordinate
        }
    }
    
    /// 附近搜索
    func poiSearch(_ location: CLLocationCoordinate2D) {
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(location.latitude), longitude: CGFloat(location.longitude))
        request.radius = 5000
        request.page = 1
        request.offset = 20
        search.aMapPOIAroundSearch(request)
    }
    
    /// 添加地图poi
    func addPoi(poi : AMapPOI) {
        self.poi = poi
        mapView.removeAnnotation(shopAnnotaion)
        let annotation = MAPointAnnotation.init()
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(poi.location.latitude), longitude: CLLocationDegrees(poi.location.longitude))
        shopAnnotaion = annotation
        mapView.addAnnotation(shopAnnotaion)
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(poi.location.latitude), longitude: CLLocationDegrees(poi.location.longitude))
    }
    
    deinit {
        print("deinit")
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AddressSearchViewController.className {
            let vc = segue.destination as! AddressSearchViewController
            
            vc.city = city
            vc.onPoiSelected = {
                [weak self] poi in
                guard let self = self else {
                    return
                }
                self.poiSearch(CLLocationCoordinate2D(latitude: CLLocationDegrees(poi.location.latitude), longitude: CLLocationDegrees(poi.location.longitude)))
                self.addPoi(poi: poi)
                self.tableView.deselectRow(at: IndexPath(row: self.index, section: 0), animated: false)
            }
        }
    }

}

extension LocationViewController : AMapLocationManagerDelegate, MAMapViewDelegate, AMapSearchDelegate {
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!) {
        print("amapLocationManager")
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        view.makeToast(error.debugDescription)
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, doRequireLocationAuth locationManager: CLLocationManager!) {
        locationManager.requestAlwaysAuthorization()
    }
    
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
       let annoationView =  mapView.dequeueReusableAnnotationView(withIdentifier: "annation")
        annoationView?.image = UIImage.init(named: "annation")
        return annoationView
    }
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        print("onPOISearchDone count:\(response.count)")
        if response.count == 0 {
            view.makeToast("无数据")
            return
        }
        poiList = response.pois
        addPoi(poi: poiList[index])
        tableView.reloadData {
            [weak self] in
            guard let self = self, self.poiList.count > 0 else {
                return
            }
            self.tableView.selectRow(at: IndexPath(row: self.index, section: 0), animated: false, scrollPosition: .none)
        }
    }
    
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        view.makeToast(error.localizedDescription)
    }

}

extension LocationViewController : UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdOrNibName, for: indexPath) as! PoiCell
        cell.model = poiList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        let poi = poiList[indexPath.row]
        addPoi(poi: poi)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        performSegue(withIdentifier: AddressSearchViewController.className, sender: nil)
    }
}

extension LocationViewController : CityDidSelectedDelegate {
    func didSelected(citySelector: CitySelectorViewController?, city: String?) {
        navigationController?.popViewController(animated: true, nil)
        self.city = city
        self.positionBtn.setTitle(city, for: .normal)
    }
}
