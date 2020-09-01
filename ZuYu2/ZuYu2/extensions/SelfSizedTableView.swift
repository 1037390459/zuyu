//
//  SelfSizedTableView.swift
//  ZuYu2
//
//  Created by million on 2020/8/9.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class SelfSizedTableView: UITableView {
  var maxHeight: CGFloat = UIScreen.main.bounds.size.height
  
  override var intrinsicContentSize: CGSize {
       self.layoutIfNeeded()
       let height = min(contentSize.height, maxHeight)
       return CGSize(width: contentSize.width, height: height)
  }
    
   override var contentSize:CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
   }
}
