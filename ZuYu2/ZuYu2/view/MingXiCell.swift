//
//  MingXiCell.swift
//  ZuYu2
//
//  Created by million on 2020/8/8.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class MingXiCell: UITableViewCell {
    
    public static let maxSize = 10
    
    @IBOutlet weak var mContentView: UIView!
    
    @IBOutlet weak var headerImgV: UIImageView!
    
    @IBOutlet weak var headerTitleLbl: UILabel!
    
    @IBOutlet weak var headerInfoLbl: UILabel!
    
    @IBOutlet weak var headerTotalLbl: UILabel!
    
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBOutlet weak var moreDashLine: DashLine!
    
    @IBOutlet weak var tableView: SelfSizedTableView!
    
    public var headerTitles = [String]()
    
    public var rowSize : Int = 0 {
        didSet {
            moreBtn.isHidden = rowSize <= MingXiCell.maxSize
            moreDashLine.isHidden = moreBtn.isHidden
        }
    }
    
    let cellIdOrNibName = MingXiInnerCell.className
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mContentView.layer.cornerRadius = 12
        mContentView.addShadow(ofColor: UIColor(red: 0.28, green: 0, blue: 0.05, alpha: 0.06), radius: 16, offset: CGSize.init(width: 0, height: 4), opacity: 1)
        tableView.backgroundColor = UIColor.clear
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.tableFooterView = UIView.init(frame: .zero)
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: cellIdOrNibName, bundle: nil), forCellReuseIdentifier: cellIdOrNibName)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        tableView.maxHeight = 1000
        moreBtn.addTarget(self, action: #selector(MingXiCell.moreBtnTapped(_:)), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        moreBtn.layoutIfNeeded()
        moreBtn.setupButtonImageAndTitlePossitionWith(padding: 5, style: .imageIsRight)
        print(moreBtn!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @objc func moreBtnTapped(_ sender : Any) {
        
    }
    
}

extension MingXiCell : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(MingXiCell.maxSize, rowSize)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdOrNibName) as! MingXiInnerCell
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: .zero)
        view.backgroundColor = UIColor.clear
        return view
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: .zero)
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
}
