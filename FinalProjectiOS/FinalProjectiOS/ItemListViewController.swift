//
//  ItemListViewController.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/30/18.
//  Copyright © 2018 Tin. All rights reserved.
//
/***************************************************************************************
 *  REFERENCES
 *  Title: SDWebImage
 *  Authors: Konstantinos K., Bogdan Poplauschi, Chester Liu, DreamPiggy, Wu Zhong
 *  Date: 12/4/2018
 *  Availability: https://github.com/SDWebImage/SDWebImage
 *  Purpose: Used SDWebImage library which is an asynchronous cache for loading images from firebase (actually directly recommended by firebase
 itself (link here: https://firebase.google.com/docs/storage/ios/download-files#downloading_images_with_firebaseui).  This was used for rounding out our cell image feature.  We had the images but had to figure out a way to manage this asynchronous process.  SDWebImage is helpful since it asynchronously loads images from firebase and caches them.  Actually recommended by firebase themselves as good solution for this asynchronous caching problem.
 *
 ***************************************************************************************/
import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import MapKit
import SDWebImage

var myLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)

var currCell:saleItem = saleItem(downloadURL: "https://", imageAbsoluteURL: "gs://", itemCategory: "", itemDescription: "", itemName: "", itemPrice: "", coordinate: myLocation, streetAddress: "", userPosted: "")

class ItemListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var ref:DatabaseReference!
    @IBOutlet weak var tableView: UITableView!
    var isFinished = false
    //var loadingAlert: UIAlertController? = nil


    
    var saleItemsList: [saleItem] = []
    override func viewDidLoad() {
        //loadingAlert = createLoadingAlert()
        createInitialArray()
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
    
        
//        let loadingAlert = UIAlertController(title: nil, message: "Retrieving Image...", preferredStyle: .alert)
//
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 2, y: 5, width: 50, height: 50))
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = UIActivityIndicatorView.Style.gray
//        loadingIndicator.startAnimating();
//        loadingAlert.view.addSubview(loadingIndicator)
//        self.present(loadingAlert, animated: true, completion: nil)
//
//        if (isFinished == true){
//            loadingAlert.dismiss(animated: false, completion: nil)
//
//        }
        
//        func createLoadingAlert() -> UIAlertController {
//            group.enter()
//            let loadingAlert = UIAlertController(title: nil, message: "Retrieving Image...", preferredStyle: .alert)
//
//            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 2, y: 5, width: 50, height: 50))
//            loadingIndicator.hidesWhenStopped = true
//            loadingIndicator.style = UIActivityIndicatorView.Style.gray
//            loadingIndicator.startAnimating();
//            loadingAlert.view.addSubview(loadingIndicator)
//            self.present(loadingAlert, animated: true, completion: nil)
//            group.leave()
//            return loadingAlert
//        }
        
//        let loadingAlert = UIAlertController(title: nil, message: "Retrieving Image...", preferredStyle: .alert)
//
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 2, y: 5, width: 50, height: 50))
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = UIActivityIndicatorView.Style.gray
//        loadingIndicator.startAnimating();
//        loadingAlert.view.addSubview(loadingIndicator)
//        self.present(loadingAlert, animated: true, completion: nil)
//        group.enter()
//        if (isFinished == true){
//            group.leave()
//        }
////        let loadingAlertResult: UIAlertController = createLoadingAlert()
//
//        // Do any additional setup after loading the view.
//        group.notify(queue:DispatchQueue.main) {
//            print("everything has been completed")
//        }
//        }
    }
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func onSegmentedControlChange(_ sender: Any) {
        if (segmentedControl.selectedSegmentIndex == 0){
            ref = Database.database().reference(withPath: "Items")
            ref.observe(.value, with: { snapshot in
                
                var saleItemsTemp: [saleItem] = []
                
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                        let item = saleItem(from: snapshot) {
                        saleItemsTemp.append(item)
                    }
                }
                self.saleItemsList = saleItemsTemp
                print("THIS IS TEMP ARR", saleItemsTemp)
                self.tableView.reloadData()
            })
        }
        //means we are on furniture
        else if (segmentedControl.selectedSegmentIndex == 1){
            ref = Database.database().reference(withPath: "Items")
            ref.observe(.value, with: { snapshot in
                
                var saleItemsTemp: [saleItem] = []
                
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                        let item = saleItem(from: snapshot) {
                        if (item.itemCategory == "Furniture"){
                            saleItemsTemp.append(item)
                        }
                    }
                }
                self.saleItemsList = saleItemsTemp
                print("THIS IS TEMP ARR", saleItemsTemp)
                self.tableView.reloadData()
            })
        }
        //means we are on school
        else if (segmentedControl.selectedSegmentIndex == 2){
            ref = Database.database().reference(withPath: "Items")
            ref.observe(.value, with: { snapshot in
                
                var saleItemsTemp: [saleItem] = []
                
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                        let item = saleItem(from: snapshot) {
                        if (item.itemCategory == "School"){
                            saleItemsTemp.append(item)
                        }
                    }
                }
                self.saleItemsList = saleItemsTemp
                print("THIS IS TEMP ARR", saleItemsTemp)
                self.tableView.reloadData()
            })
        }
        //means we are on clothes
        else if (segmentedControl.selectedSegmentIndex == 3){
            ref = Database.database().reference(withPath: "Items")
            ref.observe(.value, with: { snapshot in
                
                var saleItemsTemp: [saleItem] = []
                
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                        let item = saleItem(from: snapshot) {
                        if (item.itemCategory == "Clothes"){
                            saleItemsTemp.append(item)
                        }
                    }
                }
                self.saleItemsList = saleItemsTemp
                print("THIS IS TEMP ARR", saleItemsTemp)
                self.tableView.reloadData()
            })
        }
        //means we are on other
        else{
            ref = Database.database().reference(withPath: "Items")
            ref.observe(.value, with: { snapshot in
                
                var saleItemsTemp: [saleItem] = []
                
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                        let item = saleItem(from: snapshot) {
                        if (item.itemCategory == "Other"){
                            saleItemsTemp.append(item)
                        }
                    }
                }
                self.saleItemsList = saleItemsTemp
                print("THIS IS TEMP ARR", saleItemsTemp)
                self.tableView.reloadData()
            })
        }
    }
    
    func createInitialArray(){
//        //create saleItems
        ref = Database.database().reference(withPath: "Items")
        ref.observe(.value, with: { snapshot in
            
            var saleItemsTemp: [saleItem] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let item = saleItem(from: snapshot) {
                    print(item.itemPrice)
                    print(item.itemName)
                    saleItemsTemp.append(item)
                }
            }
            self.saleItemsList = saleItemsTemp
            print("THIS IS TEMP ARR", saleItemsTemp)
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saleItemsList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        currCell = saleItemsList[indexPath.row]
        //        performSegue(withIdentifier: "itemInfoSegue", sender: row)
        
        let itemInfoVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "itemInfo")
        self.navigationController?.pushViewController(itemInfoVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let saleItem = saleItemsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        //cell.setItemDetails(saleItem: saleItem)
        
        cell.cellName.text = saleItem.itemName
        cell.cellPrice.text = saleItem.itemPrice
        
        //used external library called SDwebimage to cache images asynchronously
        
        cell.cellImage.sd_setImage(with: URL(string: saleItem.downloadURL!), placeholderImage: UIImage(named: "placeholder"))

    
        //this is the absolute URL property not the download URL property gets the image
        //set info details for that cell
//        let group = DispatchGroup() // initialize
//        let storageRef = Storage.storage().reference(forURL: saleItem.imageAbsoluteURL)
//        storageRef.downloadURL(completion: { (url, error) in
//            if (error != nil) {
//                print("WOW BIG ERROR STOP HERE BECAUSE IMAGE HASNT BEEN LOADED")
//            }
//            else{
//                do{
//                    group.enter()
////                    let loadingAlert = UIAlertController(title: nil, message: "Loading Images...", preferredStyle: .alert)
////
////                    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 2, y: 5, width: 50, height: 50))
////                    loadingIndicator.hidesWhenStopped = true
////                    loadingIndicator.style = UIActivityIndicatorView.Style.gray
////                    loadingIndicator.startAnimating();
////                    loadingAlert.view.addSubview(loadingIndicator)
////                    self.present(loadingAlert, animated: true, completion: nil)
//
//                    let data = try Data(contentsOf: url!)
//                    let image = UIImage(data: data as Data)
//                    cell.cellImage.image = image
//                    group.leave()
//                    group.notify(queue:DispatchQueue.main) {
//                        self.isFinished = true
//                        self.loadingAlert!.dismiss(animated: false, completion: nil)
//                        print("everything has been completed")
//                    }
//                    //self.imageView.image = image
//                    //replace line above with the cellImage stuff
//
//                }catch{
//                    print("THERE WAS AN ERROR WITH TRYING TO GET THE IMAGE IN THE TRY CATCH BLOCK")
//                }
//            }
//        })
        return cell
    }
    
    

    
    func createLoadingAlert() -> UIAlertController {
        let loadingAlert = UIAlertController(title: nil, message: "Loading Item Images...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 2, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        loadingAlert.view.addSubview(loadingIndicator)
        self.present(loadingAlert, animated: true, completion: nil)
        return loadingAlert
    }
//
    func dismissLoadingAlert(loadingAlert: UIAlertController){
        loadingAlert.dismiss(animated: false, completion: nil)
    }

    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return bucketList.count
//    }
//
//    // Override to show what each cell should have in it based on the note in the list
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        // Table view cells are reused and should be dequeued using a cell identifier.
//        let cellIdentifier = "BucketListTableViewCell"
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BucketListTableViewCell
//
//        // Fetches the appropriate note for the data source layout.
//        let item = bucketList[indexPath.row]
//
//        cell.nameLabel.text = item.name
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .short
//        let convertedDate = dateFormatter.string(from: item.date)
//        cell.dateLabel.text = convertedDate
//
//        //set color to green if it is completed
//        if (item.doneStatus == true){
//            cell.backgroundColor = UIColor.green
//        }
//            //otheriwse, item color should be white (default color)
//        else{
//            cell.backgroundColor = UIColor.white
//        }
//        return cell
//    }
//
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
