//
//  SettingsTableController.swift
//  ZuYu
//
//  Created by million on 2020/7/26.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class SettingsTableController: UITableViewController {
    
    let tel = "057187063728"
    
    @IBOutlet weak var iconImgV: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        title = "设置"
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    func uploadPhoto() {
        showAlert()
    }
    
    
    /**修改性别*/
    func modifySex() {
        
    }
    
    /**联系客服*/
    func callUs() {
        let phone = "telprompt://" + tel
        if UIApplication.shared.canOpenURL(URL(string: phone)!) {
            UIApplication.shared.open(URL.init(string: phone)!)
         }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        switch row {
        case 0:
            uploadPhoto()
            break
        case 3:
            modifySex()
            break
        case 7:
            callUs()
            break
        default:
            break
        }
    }
    
    @IBAction func save() {
        
    }

}

extension SettingsTableController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        iconImgV.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}
