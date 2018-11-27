//
//  AddItemViewControllerImages.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/25/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import MobileCoreServices

class AddItemViewControllerImages: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    //code below gets image to be shown
    @IBOutlet weak var imageProgressView: UIProgressView!
    
    @IBOutlet weak var imageView: UIImageView!
    var newMedia: Bool?
    
    @IBAction func useCamera(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: false, completion: nil)
        }
        //        else{
        //            let imagePicker = UIImagePickerController()
        //            imagePicker.delegate = self
        //            imagePicker.allowsEditing = false
        //            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //            self.present(imagePicker, animated: false, completion: nil)
        //        }
    }
    
    @IBAction func useImageLibrary(_ sender: AnyObject) {
        // Add your code here
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
        }
        else{
            print("Error...")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageProgressView.layer.cornerRadius = 7
        imageProgressView.clipsToBounds = true
        imageProgressView.transform = imageProgressView.transform.scaledBy(x: 1.0, y: 4.0)
        imageProgressView.progress = 0.6666666666666666666

        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextImageAction(_ sender: Any) {
        let itemLocationVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "itemLocationVC")
        self.navigationController?.pushViewController(itemLocationVC, animated: true)
    }

    @IBAction func backImageAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
