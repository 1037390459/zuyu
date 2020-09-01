//
//  GdShopTableController.swift
//  ZuYu2
//
//  Created by million on 2020/8/16.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class GdShopTableController: UITableViewController {

    let cellIdOrNibName = GdShopCell.className
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationItem()
        tableView.backgroundColor = UIColor.init(hexString: "#FCFCFC")
        tableView.tableFooterView = UIView.init(frame: .zero)
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: cellIdOrNibName, bundle: nil), forCellReuseIdentifier: cellIdOrNibName)
        tableView.rowHeight = GdShopCell.fitHeight
    }
    
    func initNavigationItem()  {
        navigationItem.title = "千行店面管理"
        let qiehuan = UIBarButtonItem.init(image: UIImage.init(named: "qiehuan")?.withTintColor(Constant.Color.primaryDark).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(JiShiController.qiehuan(_:)))
        navigationItem.rightBarButtonItem = qiehuan
    }
    
    func showActionSheet() {
        let vc = RoleController.init(nibName: RoleController.className, bundle: nil)
        vc.type = .gudong
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
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdOrNibName, for: indexPath) as! GdShopCell
        
        cell.selectionStyle = .none
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
