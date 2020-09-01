//
//  JSNavigationController.swift
//  ZuYu2
//
//  Created by million on 2020/8/17.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class JSNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let font = UIFont.systemFont(ofSize: 20)
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: -screenWidth, height: 0)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: navigationBar.titleTextAttributes?[.font] ?? font,
            .foregroundColor: navigationBar.titleTextAttributes?[.foregroundColor] ?? UIColor.white,
            .shadow: shadow
        ]
        navigationBar.titleTextAttributes = attributes
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
