//
//  FeedBackController.swift
//  ZuYu
//
//  Created by million on 2020/7/26.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class FeedBackController: UIViewController {
    
    private let maxCount = 200
    
    @IBOutlet weak var textView: TextViewWithPlaceholder!
    
    @IBOutlet weak var countLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func countFormat(count : Int) -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: "*您还能写\(count)字")
        let attr : [NSAttributedString.Key : Any] =  [
                   .font: UIFont.systemFont(ofSize: 12),
                   .foregroundColor: Constant.Color.lightPrimaryDark]
        let attr2 : [NSAttributedString.Key : Any] = [
                    .font: UIFont.systemFont(ofSize: 12),
                    .foregroundColor: Constant.Color.red]
        attrString.addAttributes(attr, range: NSRange(location: 0, length:          attrString.length))
        attrString.addAttributes(attr2, range: NSRange(location: 0, length: 1))
        return attrString
    }
    
    func setUpUI()  {
        textView.delegate = self
        countLbl.attributedText = countFormat(count: maxCount)
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

extension FeedBackController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let leftCount = maxCount - textView.text.count
        countLbl.attributedText = countFormat(count: leftCount)
    }
}
