//
//  ScreenerResultsVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 5/8/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase

class ScreenerResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    public var attachedResourceCategories:[String]?
    
    //   var resources = [ResourcesModel]()
    //var refResources: DatabaseReference!
    
    
    
    
    //    var resultsModel:ResourcesModel?
    //  var   resource:ResourcesModel?
    
    var dictionaryOfResourceArrays = [String: [ResourcesModel]]()
    var arrayOfResourceArrays = [[ResourcesModel]]()
    var selectedResource : IndexPath?
    var refResources: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refResources = Database.database().reference().child("services");
        
        for resourceStr in attachedResourceCategories! {
            
            addArrayOfResourcesToArrayOfArrays(category: resourceStr);
            
        }
        //  self.tableView.reloadData()
        
    }
    
    func addArrayOfResourcesToArrayOfArrays(category: String)  {
        
        var resourcesArray = [ResourcesModel]()
        
        refResources.observe(DataEventType.value, with: {(snapshot) in
            // refResources.queryOrdered(byChild: "Name").observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0 {
                for resources in snapshot.children.allObjects as![DataSnapshot] {
                    let resourceObject = resources.value as? [String: AnyObject]
                    if (resourceObject!["category" + category] != nil) {
                        let resourceName = resourceObject?["Name"]
                        let resourceWebsite = resourceObject?["Website"]
                        let resourceEmail = resourceObject?["Email"]
                        let resourcePhone = resourceObject?["Phone"]
                         let resourceLocation = resourceObject?["Location"]
                        
                        let resource = ResourcesModel(Name: resourceName as! String?, Website: resourceWebsite as! String?, Email: resourceEmail as! String?, Phone: resourcePhone as! String?, Location: resourceLocation as! String?)
                        resourcesArray.append(resource)
                        self.arrayOfResourceArrays.append(resourcesArray)
                    }
                }
            }
            self.tableView.reloadData()
        }) //end
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "sectionHeader")
        headerCell?.textLabel?.text = attachedResourceCategories?[section]
        return headerCell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return attachedResourceCategories!.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return attachedResourceCategories?[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayOfResourceArrays.count == 0 {
            return 0;
        }
        else {
            return self.arrayOfResourceArrays[section].count
        }
        //  return arrayOfResourceArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let thisResource = arrayOfResourceArrays[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellResult", for: indexPath)
 
        cell.textLabel?.text = thisResource.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let thisRes = arrayOfResourceArrays[indexPath.section][indexPath.row]
        let siteString = thisRes.website
        let siteURL = URL(string: siteString!)
        UIApplication.shared.open(siteURL!)

    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailVC = segue.destination as? ResourceDetailVC
        let sectionIndex = selectedResource?.section
        let rowIndex = selectedResource?.row
        detailVC?.resource = arrayOfResourceArrays[sectionIndex!][rowIndex!]
    }
    
    
    
}








