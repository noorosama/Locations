//
//  ViewController.swift
//  Task1
//
//  Created by Nour Abukhaled on 3/2/18.
//  Copyright © 2018 Nour Abukhaled. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

enum locationType: Int {
    case cashOut
    case branches
}

class locatorViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate
{
    
    @IBOutlet var locationTypeSegmentController: UISegmentedControl!
    @IBOutlet var locationsTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredDataArray = [locations]()
    var isSearching = false
    

    var selecedLocation : locations? = nil
    
    var cashOutsArray: [locations] = []
    var branchesArray: [locations] = []
    var notificationArray: [locations] = []

    var selectedLocationType: locationType = locationType.cashOut
    var tableViewDataSourceArray: [locations] = []
    
    var jsonResponse = JsonResponse()
    
    var id: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detaileViewController = storyboard.instantiateViewController(withIdentifier: "secondController") as! detailesViewController
        
        if AppDelegate.globalVariabels.isNotification {
            
            if AppDelegate.globalVariabels.branchNotification == "" {
                
                jsonResponse.getCashOutsJson { (locations) in
                    
                    self.cashOutsArray = locations
                    self.notificationArray = self.cashOutsArray
                    self.id = AppDelegate.globalVariabels.ATMNotification
                    
                    for notificationLocation in self.notificationArray {
                        
                        if notificationLocation.ID == self.id {
                            
                            detaileViewController.latitude = (notificationLocation.LocX)
                            detaileViewController.longitude = (notificationLocation.LocY)
                            detaileViewController.titleName = (notificationLocation.title)
                            
                            self.navigationController?.pushViewController(detaileViewController, animated: true)
                            
                            break
                        }
                    }
                }
                
            } else {
                jsonResponse.getBranchesJson { (locations) in
                    
                    self.branchesArray = locations
                    self.notificationArray = self.branchesArray
                    self.id = AppDelegate.globalVariabels.branchNotification
                    
                    for notificationLocation in self.notificationArray {
                        
                        if notificationLocation.ID == self.id {
                            
                            detaileViewController.latitude = (notificationLocation.LocX)
                            detaileViewController.longitude = (notificationLocation.LocY)
                            detaileViewController.titleName = (notificationLocation.title)
                            
                            self.navigationController?.pushViewController(detaileViewController, animated: true)
                            
                            break
                        }
                    }
                }
            }
        } else {
            
            selectedLocationType = locationType.cashOut
            
            requestCashouts()
            
            searchBar.delegate = self
            searchBar.returnKeyType = UIReturnKeyType.done
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(showCashoutDetailesViewController(notification:)), name: NSNotification.Name(rawValue: "didReceiveNotification"), object: nil)
    }
    
    
    func getBranches() {
        let request = ATMRequest(latitude: 35, longtude: 32)
        APIClient.execute(request: request, success: { locations in
            
        }) { (errorMessage) in
            
        }
    }
    
//    func requestLogin() {
//        let loginRequest = LoginRequest(username: "anas", password: "1245")
//        APIClient.execute(request: loginRequest, success: <#T##([locations]) -> Void#>, failure: <#T##(String) -> Void#>)
//    }
    
    
    
    @objc func showCashoutDetailesViewController(notification: NSNotification){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let detaileViewController = storyboard.instantiateViewController(withIdentifier: "secondController") as! detailesViewController
        
        
        let branchId = notification.userInfo?["BranchID"] as? String ?? ""
        let ATMId = notification.userInfo?["ATMID"] as? String ?? ""
        
        if ATMId == "" {
            
            notificationArray = branchesArray
            id = branchId
            
        }else{
            
            notificationArray = cashOutsArray
            id = ATMId
            
        }
        
        for notificationLocation in notificationArray {
            
            if notificationLocation.ID == id {
                
                detaileViewController.latitude = (notificationLocation.LocX)
                detaileViewController.longitude = (notificationLocation.LocY)
                detaileViewController.titleName = (notificationLocation.title)
                
                navigationController?.pushViewController(detaileViewController, animated: true)
                
                break
            }
        }
    }
    
    func requestCashouts() {
        
        if cashOutsArray == [] {
        
        jsonResponse.getCashOutsJson { (locations) in
            self.cashOutsArray = locations
            self.tableViewDataSourceArray = locations
            self.locationsTableView.reloadData()
        }
        
        } else {
            self.tableViewDataSourceArray = cashOutsArray
            self.locationsTableView.reloadData()
        }

    }
    
    func requestBranches() {
        
        if branchesArray == [] {
            
            jsonResponse.getBranchesJson { (locations) in
                self.branchesArray = locations
                self.tableViewDataSourceArray = locations
                self.locationsTableView.reloadData()
            }
            
        } else {
            self.tableViewDataSourceArray = branchesArray
            self.locationsTableView.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func segmentedControlActionChanged(_ sender: Any) {
        
        
        selectedLocationType = locationType(rawValue:locationTypeSegmentController.selectedSegmentIndex)!
        
        if isSearching && selectedLocationType == locationType.cashOut {

            requestCashouts()

            searchBar.text = ""

            isSearching = false

        } else if isSearching && selectedLocationType == locationType.branches{

            requestBranches()

            searchBar.text = ""

            isSearching = false
            
        }
        
         else if selectedLocationType == locationType.cashOut  {
            
            requestCashouts()
            
        }else{
            
            requestBranches()
            
        }
        
        locationsTableView.reloadData()
        
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableViewDataSourceArray.isEmpty {
            return 0
        } else {
            return  isSearching ? 1:2
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            
            return filteredDataArray.count
            
        }else {
            
            switch section {
            case 0:
                return 2
            case 1:
                return tableViewDataSourceArray.count - 2
            default:
                return 0
            
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let locationCell = tableView.dequeueReusableCell(withIdentifier: "LocatorCell", for: indexPath) as? LocatorCell
            else {
                return UITableViewCell()
        }
        
        var location : locations
        
        if indexPath.section == 0 && isSearching == false {
            
            location = tableViewDataSourceArray[indexPath.row]
            locationCell.navigateButton.tag = indexPath.row
            
        }else if indexPath.section == 1 && isSearching == false {
            
            location = tableViewDataSourceArray[indexPath.row + 2]
            locationCell.navigateButton.tag = indexPath.row + 2
            
        }else {
            
            location = filteredDataArray[indexPath.row]
        }
        
        locationCell.titleLabel.text =  location.title
        
        locationCell.descriptionLabel.text = location.desrp
        
        locationCell.navigateButton.addTarget(self, action: #selector(startNavigation(_:)), for: .touchUpInside)
        
        return locationCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        locationsTableView.estimatedRowHeight = 80
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if selectedLocationType == locationType.cashOut {
            
            return self.getCashoutSectionHeader(section: section )
            
        }else if selectedLocationType == locationType.branches {
            
            return  self.getBranchesSectionHeader(section: section)
        }
            
        else { return "" }
    }
    
    func getCashoutSectionHeader(section: Int) -> String {
        
        switch section {
            
        case 0:
            
            if isSearching{
                
                return "Cash-outs"
                
            }else{
                
                return "Nearest Cash-outs"
            }
            
        case 1:
            
            return "Cash-outs"
            
        default:
            return ""
        }
        
    }
    
    func getBranchesSectionHeader(section: Int) -> String {
        
        switch section {
            
        case 0:
            
            if isSearching{
                
                return "Branches"
            }else{
                return "Nearest Branches"
            }
            
        case 1:
            return "Branches"
            
        default:
            return ""
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        
        if let headerTitle = view as? UITableViewHeaderFooterView {
            
            headerTitle.textLabel?.textColor = UIColor.lightGray
            headerTitle.textLabel?.font = UIFont(name: "Futura", size: 14)
            locationsTableView.tableFooterView = UIView()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 0 {
            
            self.selecedLocation = self.tableViewDataSourceArray[indexPath.row]
            
        }else{
            
            self.selecedLocation = self.tableViewDataSourceArray[indexPath.row + 2]
            
        }
        
        if isSearching {
            self.selecedLocation = self.filteredDataArray[indexPath.row]
            searchBar.text = nil
            isSearching = false
           
            
        }
        
        self.performSegue(withIdentifier: "DetailesSegue", sender: nil)
        
        locationsTableView.reloadData()
        
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailesSegue" {
            
            let detailViewController = segue.destination as! detailesViewController
            detailViewController.latitude = (selecedLocation?.LocX)!
            detailViewController.longitude = (selecedLocation?.LocY)!
            detailViewController.titleName = (selecedLocation?.title)!
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchBar.text == nil || searchBar.text == "" {
            
            isSearching = false
            view.endEditing(true)
            locationsTableView.reloadData()
            
        }else{
            
            isSearching = true
            getFilteredDataArray(searchText: searchText)
            locationsTableView.reloadData()
            
        }
    }
    
    func getFilteredDataArray(searchText: String){
        
        filteredDataArray = tableViewDataSourceArray.filter({
            $0.title.prefix(searchText.count) == searchText.prefix(searchText.count)

        })
        
    }
    
    @objc func startNavigation(_ sender: UIButton){
        
        
        let buttonInbox = sender.tag
        let location = tableViewDataSourceArray[buttonInbox]
        
        let stringURL = "comgooglemaps://?saddr=&daddr=\(Float(location.LocX)),\(Float(location.LocY))&directionsmode=driving"
        let url = URL(string: stringURL)!
        
        if UIApplication.shared.canOpenURL(url){
            
            UIApplication.shared.open(url)
            
        }else{
            
            print("Could not open google maps")
            
        }
    }
}

