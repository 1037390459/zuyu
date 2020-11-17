//
//  AddressSearchViewController.swift
//  ZuYu2
//
//  Created by million on 2020/11/7.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class AddressSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var search : AMapSearchAPI!
    
    let cellIdOrNibName = PoiCell.className
    
    var poiList : [AMapPOI] = []
    
    var city : String?
    
    var onPoiSelected : ((AMapPOI)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI() {
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        
        tableView.backgroundColor = UIColor.init(hexString: "#FCFCFC")
        tableView.tableFooterView = UIView.init(frame: .zero)
        tableView.register(UINib.init(nibName: cellIdOrNibName, bundle: nil), forCellReuseIdentifier: cellIdOrNibName)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        
        search = AMapSearchAPI()
        search.delegate = self
    }
    
    /// 关键字搜索
    func poiKeyWordSearch(_ keyword: String?) {
        let request = AMapPOIKeywordsSearchRequest()
        request.city = city
        request.types = ""
        request.keywords = keyword
        request.cityLimit = true
        request.page = 1
        request.offset = 20
        search.aMapPOIKeywordsSearch(request)
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

extension AddressSearchViewController : UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
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
        let poi = poiList[indexPath.row]
        onPoiSelected?(poi)
        dismiss(animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        poiKeyWordSearch(searchBar.text)
    }
    
}

extension AddressSearchViewController :  AMapSearchDelegate {
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        print("onPOISearchDone count:\(response.count)")
        if response.count == 0 {
            return
        }
        poiList = response.pois
        tableView.reloadData()
    }
    
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        view.makeToast(error.localizedDescription)
    }

}
