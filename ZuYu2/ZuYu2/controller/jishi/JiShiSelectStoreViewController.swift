//
//  JiShiSelectStoreControllerViewController.swift
//  ZuYu2
//
//  Created by Rain on 2021/5/6.
//  Copyright © 2021 million. All rights reserved.
//

import UIKit

class JiShiSelectStoreViewController: UIViewController {
    
    @IBOutlet weak var selected1: UIButton!
    @IBOutlet weak var selected2: UIButton!
    
    @IBOutlet weak var selected1Label: UILabel!
    @IBOutlet weak var selected2Label: UILabel!
    
    
    var userBean : UserBean?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
    }
    
    func initUI(){
         let userStroeList = userBean?.stores
        if !(userStroeList?.isEmpty ?? true){
            if let store = userStroeList?[0]{
                selected1Label.text = store.storeName
            }
            if let store2 = userStroeList?[1]{
                selected2Label.text = store2.storeName
            }
        }
    }
    
    @IBAction func selected1Click(_ sender: Any){
        selected1.isSelected = !selected1.isSelected
    }
    
    @IBAction func selected2Click(_ sender: Any){
        selected2.isSelected = !selected2.isSelected
    }

    @IBAction func sureBtnClick(_ sender: Any){
        clientType = ClientType(rawValue: userBean?.userType ?? "JS")
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
