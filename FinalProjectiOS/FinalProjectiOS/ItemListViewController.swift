//
//  ItemListViewController.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/30/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
//var saleItemsList = [saleItem]()
// add this later UITableViewDataSource, UITableViewDelegate

class ItemListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var saleItemsList: [saleItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saleItemsList = createInitialArray()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func createInitialArray() -> [saleItem]{
//        //create saleItems
        var tempSalesList : [saleItem] = []
        let salesItem1 = saleItem(itemImage: "Item1 Image", itemName: "Item1 Name", itemSeller: "ChrisYeung" , itemPrice: "$10.50")
        let salesItem2 = saleItem(itemImage: "Item2 Image", itemName: "Item2 Name", itemSeller: "ChrisYeung" , itemPrice: "$11.50")
        let salesItem3 = saleItem(itemImage: "Item3 Image", itemName: "Item3 Name", itemSeller: "ChrisYeung" , itemPrice: "$12.50")
        let salesItem4 = saleItem(itemImage: "Item4 Image", itemName: "Item4 Name", itemSeller: "ChrisYeung" , itemPrice: "$13.50")
        
        tempSalesList.append(salesItem1)
        tempSalesList.append(salesItem2)
        tempSalesList.append(salesItem3)
        tempSalesList.append(salesItem4)
        return tempSalesList
//        //requires retrieving information from firebase
//        //have tempArray in here
//        //appended items in that tempArray and return it
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
