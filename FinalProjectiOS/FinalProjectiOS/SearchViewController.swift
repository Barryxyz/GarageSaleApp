//
//  SearchViewController.swift
//  FinalProjectiOS
//
//  Created by Chin, Barry Xiu Yin (bxc2gn) on 11/27/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
//    let countryNameArr = ["cheese"]
//    var searchCountry = [String]()
//    var searching = false
//    var arrayAddress = [GMSAutocompletePrediction]()
//    lazy var filter: GMSAutocompleteFilter = {
//       let filter = GMSAutocompleteFilter()
//        filter.type = .address
//        return filter
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
//    func loadUI(){
//        table.tableFooterView = UIView()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//}

//extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrayAddress.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
//        }
//        cell?.textLabel?.attributedText = arrayAddress[indexPath.row].attributedFullText
//        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
//        return cell!
//    }
//}
//
//extension SearchViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let searchStr = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//        if searchStr == "" {
//            self.arrayAddress = [GMSAutocompletePrediction]()
//        }
//        else {
//            GMSPlacesClient.shared().autocompleteQuery(searchStr, bounds: nil, filter: filter, callback: { (result, error) in
//                if error == nil && result != nil {
//                    self.arrayAddress = result!
//                }
//            })
//        }
//        self.table.reloadData()
//        return true;
//    }
//}
