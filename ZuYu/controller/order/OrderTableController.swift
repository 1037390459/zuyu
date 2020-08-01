//
//  OrderController.swift
//  ZuYu
//
//  Created by million on 2020/7/12.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class OrderTableController: UITableViewController {
    
    private let cellClassName = OrderCell.className
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的订单"
        initTable()
        // Do any additional setup after loading the view.
    }
    
    func initTable() {
        //String.init(describing: type(of: OrderCell.Type))
        tableView.register(UINib.init(nibName: cellClassName, bundle: nil), forCellReuseIdentifier: cellClassName)
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
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

extension OrderTableController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderCell = tableView.dequeueReusableCell(withIdentifier: cellClassName) as! OrderCell
        orderCell.commentClosure = {
            [weak self] in
            self?.performSegue(withIdentifier: CommentController.className, sender: nil)
        }
        return orderCell
    }
    
}
