//
//  DurationView.swift
//  ZuYu2
//
//  Created by million on 2020/8/22.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class DateTextView : TextViewWithPlaceholder {
    
    lazy var datePicker = { () -> UIDatePicker in
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        return picker
    }()
    
    lazy var toolbar = { () -> UIToolbar in
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        return toolbar
    }()
    
    lazy var items = { () -> [UIBarButtonItem] in
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done(_:)))
        return [cancelButton, space, doneButton]
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        toolbar.frame = CGRect(x: 0, y: 0, width: width, height: 44)
        toolbar.items = items
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp() {
        inputView = datePicker
        inputAccessoryView = toolbar
    }
    
    @objc func cancel(_ sender : Any) {
        _ = resignFirstResponder()
    }
    
    @objc func done(_ sender : Any) {
        text = datePicker.date.string(withFormat: "yyyy.MM.dd HH:mm")
        _ = resignFirstResponder()
    }
    
}

class DurationView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var startTimeTv: DateTextView!
    
    @IBOutlet weak var endTimeTv: DateTextView!
    
    @IBOutlet weak var queryBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        contentView = (Bundle.main.loadNibNamed(DurationView.className, owner: self, options: nil)?.last as! UIView)
        addSubview(contentView)
        bottomView.addShadow(ofColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.03), radius: 4, offset: CGSize(width: 0, height: 2), opacity: 1)
        startTimeTv.placeholderText = "开始时间"
        startTimeTv.backgroundColor = UIColor(hexString: "#F3F6F7")
        startTimeTv.cornerRadius = 3
        endTimeTv.placeholderText = "结束时间"
        endTimeTv.backgroundColor = UIColor(hexString: "#F3F6F7")
        endTimeTv.cornerRadius = 3
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = frame
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
