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
import Alamofire

class PlatformStepTwoController: UIViewController {
    
    @IBOutlet weak var nameTf: CustomTextField!
    
    @IBOutlet weak var telTf: CustomTextField!
    
    @IBOutlet weak var addressTf: CustomTextField!
    
    @IBOutlet weak var noteTv: TextViewWithPlaceholder!
    
    @IBOutlet weak var uploadBtn: UIButton!
    
    var password : String?
    
    var regMobile : String?
    
    var code : String?
    
    var licenseUrl : String?
    
    var iv : String?
    
    var poi : AMapPOI?
    
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
        performSegue(withIdentifier: LocationViewController.className, sender: nil)
    }
    
    func register() {
        NetManager.request(.getDynamicKey, entity: Dictionary<String, String>.self)
            .flatMap({ [weak self] (dict) -> Observable<Int> in
                guard let self = self else { return Observable.empty()}
                var params : [String : Any] = [:]
                params["iv"] = dict["iv"]
                params["regMobile"] = self.regMobile
                params["code"] = self.code
                params["password"] = try? self.password?.aesEncrypt(key: dict["key"] ?? "", iv: dict["iv"] ?? "")
                if let poi = self.poi, poi.address == self.addressTf.text {
                    params["lat"] = poi.location.latitude
                    params["lng"] = poi.location.longitude
                    params["storeName"] = poi.name
                }
                params["address"] = self.addressTf.text
                params["licenseUrl"] = self.licenseUrl
                params["regName"] = self.nameTf.text
                params["regTelPhone"] = self.telTf.text
                params["remark"] = self.noteTv.text
                return  NetManager.request(.qxFloorRegistration(params), entity: Int.self)
            })
            .subscribe(onNext: { [weak self] (result) in
                guard let self = self else { return }
                self.performSegue(withIdentifier: PlatformStepThreeController.className, sender: nil)
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

    func uploadFile(fileName : String, data : Data) {
        NetManager.request(.uploadData(fileName, data), entity: Dictionary<String, String>.self)
            .subscribe(onNext: { [weak self] (dict) in
                guard let self = self else { return }
                self.licenseUrl = dict["url"]
                }, onError: { (e) in
                    print(e)
                SVProgressHUD.dismiss()
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func next(_ sender: Any) {
        register()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PlatformStepThreeController.className {
            let vc = segue.destination as! PlatformStepThreeController
        }
        if segue.identifier == LocationViewController.className {
            let vc = segue.destination as! LocationViewController
            vc.onAddressCallBack =  {
                [weak self] poi in
                guard let self = self else {
                    return
                }
                self.poi = poi
                self.addressTf.text = poi.address
            }
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
        let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as! URL
        uploadFile(fileName: imageUrl.lastPathComponent, data: image.jpegData(compressionQuality: 0.2)!)
        uploadBtn.restInset()
        uploadBtn.setTitle(nil, for: .normal)
        uploadBtn.setImage(image, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
}
