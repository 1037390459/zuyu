//
//  PlatformStepTwoController.swift
//  ZuYu2
//
//  Created by million on 2020/8/2.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import SVProgressHUD

class PlatformStepTwoController: UIViewController {
    
    @IBOutlet weak var nameTf: CustomTextField!
    
    @IBOutlet weak var telTf: CustomTextField!
    
    @IBOutlet weak var addressTf: CustomTextField!
    
    @IBOutlet weak var noteTv: TextViewWithPlaceholder!
    
    @IBOutlet weak var uploadBtn: UIButton!
    
    let disposeBag = DisposeBag()
    
    lazy var mapBtn: UIButton = {
        let mapBtn = UIButton(type: .custom)
        mapBtn.setTitle("打开地图>", for: .normal)
        mapBtn.setTitleColor(Constant.Color.primary, for: .normal)
        mapBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mapBtn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        mapBtn.sizeToFit()
        mapBtn.addTarget(self, action: #selector(openMap(_:)), for: .touchUpInside)
        return mapBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        uploadBtn.setupButtonImageAndTitlePossitionWith(padding: 18, style: .imageIsTop)
        noteTv.placeholderText = "请输入备注"
        noteTv.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        addressTf.rightView = mapBtn
        addressTf.rightViewMode = .always
    }
    
    @objc func openMap(_ sender : Any) {
        
    }
    
    func refreshSession() {
        
    }
    
    func register() {
        SVProgressHUD.show()
                let dict = ["" : ""]
                provider.rx.request(.qxFloorRegistration(dict), callbackQueue: DispatchQueue.main)
                .asObservable()
                .map(ApiBaseModel<EmptyModel>.self)
                .subscribe(onNext: { [weak self] (result) in
                    SVProgressHUD.dismiss()
                    guard let self = self else { return }
                    }, onError: { (e) in
                        print(e)
                        SVProgressHUD.dismiss()
                })
                .disposed(by: disposeBag)
    }
    
    @IBAction func upload(_ sender: Any) {
        print("upload")
        showAlert()
    }
    
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: PlatformStepThreeController.className, sender: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PlatformStepThreeController.className {
            let vc = segue.destination as! PlatformStepThreeController
        }
    }
    
    
}

extension PlatformStepTwoController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showAlert()  {
        let alertController=UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel=UIAlertAction(title:"取消", style: .cancel, handler: nil)
        let takingPictures=UIAlertAction(title:"拍照", style: .default)
        {
            action in
            self.goCamera()
        }
        let localPhoto=UIAlertAction(title:"从相册中选取", style: .default)
        {
            action in
            self.goAlbum()
            
        }
        alertController.addAction(cancel)
        alertController.addAction(takingPictures)
        alertController.addAction(localPhoto)
        self.present(alertController, animated:true, completion:nil)
    }
    
    func goAlbum(){
        let photoPicker =  UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = true
        photoPicker.sourceType = .photoLibrary
        self.present(photoPicker, animated: true, completion: nil)
        
    }
    
    func goCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            print("不支持拍照")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("获得照片============= \(info)")
        let image : UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        uploadBtn.restInset()
        uploadBtn.setTitle(nil, for: .normal)
        uploadBtn.setImage(image, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
}
