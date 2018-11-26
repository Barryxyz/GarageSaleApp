//
//  AddItemViewController.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/19/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import CoreLocation

class AddItemViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var infoProgressBar: UIProgressView!
    
    
    //sets up picker view for categoryTextField
    
    let contactPickerData = [String](arrayLiteral:"Furniture", "School", "Clothes", "Other")
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return contactPickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return contactPickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = contactPickerData[row]
    }
    
    @IBAction func nextActionTwo(_ sender: Any) {
        infoProgressBar.progress = 0.333333333333333333
        let itemImageVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "itemImageVC")
        self.navigationController?.pushViewController(itemImageVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //places a border around the textview (which by default, doesn't have one)
        self.descriptionTextView.layer.borderWidth = 0.5
        self.descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.descriptionTextView.layer.cornerRadius = 7
        let contactPicker = UIPickerView()
        categoryTextField.inputView = contactPicker
        contactPicker.delegate=self
        //set corners for the progress bar so it's not directly connected to the edges and also make it larger so it is more visible to user
        infoProgressBar.layer.cornerRadius = 7
        infoProgressBar.clipsToBounds = true
        infoProgressBar.transform = infoProgressBar.transform.scaledBy(x: 1.0, y: 4.0)
        // Do any additional setup after loading the view.
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
