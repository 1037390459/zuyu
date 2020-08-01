//
//  HomeController.swift
//  ZuYu
//
//  Created by million on 2020/7/12.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import SwifterSwift

class HomeController: UIViewController {
    
    @IBOutlet weak var filterBtn: UIButton!
    
    @IBOutlet weak var conditionStackView: UIStackView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var locateBtn : ExtraImageButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
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
        tableView.register(UINib.init(nibName: "ShopCell", bundle: nil), forCellReuseIdentifier: "cellId")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        tableView.separatorStyle = .none
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
        let index = conditionStackView.arrangedSubviews.firstIndex(of: sender)
        print(index ?? "none")
        for view in conditionStackView.arrangedSubviews {
            if let button = view as? UIButton {
                button.isSelected = false
            }
        }
        sender.isSelected = !sender.isSelected
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}

extension HomeController : CityDidSelectedDelegate {
    func didSelected(citySelector: CitySelectorViewController?, city: String?) {
        navigationController?.popViewController(animated: true, nil)
        locateBtn.setTitle(city, for: .normal)
        locateBtn.sizeToFit()
    }
}
