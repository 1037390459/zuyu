//
//  ProfileViewController.swift
//  ZuYu2
//
//  Created by million on 2020/11/10.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var iconBtn: UIButton!
    
    @IBOutlet weak var signatureTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.init(hexString: "#FCFCFC")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        showAlert()
    }
    
    
    @IBAction func save(_ sender: Any) {
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

extension ProfileTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
//        uploadFile(fileName: imageUrl.lastPathComponent, data: image.jpegData(compressionQuality: 0.2)!)
        iconBtn.setImage(image, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
}

