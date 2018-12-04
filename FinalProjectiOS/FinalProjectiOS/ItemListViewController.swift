//
//  ItemListViewController.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/30/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import MapKit
//var saleItemsList = [saleItem]()
// add this later UITableViewDataSource, UITableViewDelegate

class ItemListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var ref:DatabaseReference!
    @IBOutlet weak var tableView: UITableView!
    
    var saleItemsList: [saleItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(saleItemsList)
        createInitialArray()
        print(saleItemsList)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let saleItem = saleItemsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        //set info details for that cell
        cell.setItemDetails(saleItem: saleItem)
        return cell
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
