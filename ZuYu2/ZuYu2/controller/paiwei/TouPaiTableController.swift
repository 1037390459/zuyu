//
//  TouPaiTableController.swift
//  ZuYu2
//
//  Created by million on 2020/8/9.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class TouPaiTableController: UITableViewController {
    
    @IBOutlet weak var jinPaiCell: UITableViewCell!
    
    @IBOutlet weak var yinPaiCell: UITableViewCell!
    
    @IBOutlet weak var tongPaiCell: UITableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.init(hexString: "#FCFCFC")
        tableView.tableFooterView = UIView.init(frame: .zero)
        tableView.separatorStyle = .none
        tableView.rowHeight = 170
        jinPaiCell.addShadow(ofColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.03), radius: 10, offset: CGSize.init(width: 0, height: 2), opacity: 1)
        yinPaiCell.addShadow(ofColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.03), radius: 10, offset: CGSize.init(width: 0, height: 2), opacity: 1)
        tongPaiCell.addShadow(ofColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.03), radius: 10, offset: CGSize.init(width: 0, height: 2), opacity: 1)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: .zero)
        view.backgroundColor = UIColor.clear
        return view
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: .zero)
        view.backgroundColor = UIColor.clear
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
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
