//
//  AddItemViewControllerImages.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/25/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit

class AddItemViewControllerImages: UIViewController {

    
    @IBOutlet weak var imageProgressView: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageProgressView.layer.cornerRadius = 7
        imageProgressView.clipsToBounds = true
        imageProgressView.transform = imageProgressView.transform.scaledBy(x: 1.0, y: 4.0)
        imageProgressView.progress = 0.333333333333333333

        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextImageAction(_ sender: Any) {
        imageProgressView.progress = 0.6666666666666666666
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
