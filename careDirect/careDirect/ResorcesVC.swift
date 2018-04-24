//
//  ResorcesVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/21/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase

class ResorcesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var tableContainer: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var resourcesCategories: UITextField!
    
    let categories = ["Housing", "Education", "Health", "Immigration", "Substance Treatment", "Prevention"]
    
    var pickerView = UIPickerView()
    var refResources: DatabaseReference!
    var resources = [ResourcesModel]()
    var selectedIndexPath: ResourcesModel?
    
    private var dpShowWebsiteVisible = false
    private var dpShowEmailVisible = false
    private var dpShowPhoneVisible = false
  
// Organization List
    @IBOutlet weak var organizationContainer: UITableView!
       var organizations = [OrganizationModel]()
       var selectedPath: OrganizationModel?
       var   refOrganizations: DatabaseReference!

    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        resourcesCategories.text = categories[row]
      //  resourcesCategories.text = categories[2]
        resourcesCategories.resignFirstResponder()
    }
    
    private func toggleContent() {
        dpShowWebsiteVisible = !dpShowWebsiteVisible
        dpShowEmailVisible = !dpShowEmailVisible
        dpShowPhoneVisible = !dpShowPhoneVisible
        
        tableContainer.beginUpdates()
        tableContainer.endUpdates()
    }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
      //  return (resources.count + organizations.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

        let cell = tableView.dequeueReusableCell(withIdentifier: "refCell", for: indexPath) as! ResourceTableViewCell
        let resource: ResourcesModel
        resource = resources[indexPath.row]
        cell.lblName.text = resource.name
        cell.lblWebsite.text = resource.website
        cell.lblEmail.text = resource.email
        cell.lblPhone.text = resource.phone
        
            return cell
        
        
      /*  let orgCell = tableView.dequeueReusableCell(withIdentifier: "orgCell", for: indexPath) as! OrganizationTableViewCell
        
    let organization: OrganizationModel
       organization = organizations[indexPath.row]
        orgCell.lblName.text = organization.name

        return (orgCell)   */

    }
    
    
    //test
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let indexPath = tableContainer.indexPathForSelectedRow!
          selectedIndexPath = resources[indexPath.row]
        
         toggleContent()
         tableContainer.deselectRow(at: indexPath, animated: true)
        
         }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       if  indexPath == tableContainer.indexPathForSelectedRow {
       //        if dpShowWebsiteVisible{           //on click hide and show all cells
            return ResourceTableViewCell.expandedHeight
        } else {
               return ResourceTableViewCell.defaultHeight
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.updatesVisibleSegment()
        pickerView.delegate = self
        pickerView.dataSource = self
        resourcesCategories.inputView = pickerView  
        resourcesCategories.textAlignment = .center
        resourcesCategories.placeholder = "Select Category"
        
        refResources = Database.database().reference().child("services");
        
        refResources.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0 {
                self.resources.removeAll()
                
                for resources in snapshot.children.allObjects as![DataSnapshot] {
                    let resourceObject = resources.value as? [String: AnyObject]
                    let resourceName = resourceObject?["Name"]
                    let resourceWebsite = resourceObject?["Website"]
                    let resourceEmail = resourceObject?["Email"]
                    let resourcePhone = resourceObject?["Phone"]
                    
                    let resource = ResourcesModel(Name: resourceName as! String?, Website: resourceWebsite as! String?, Email: resourceEmail as! String?, Phone: resourcePhone as! String?)
                    self.resources.append(resource)
                }
                self.tableContainer.reloadData()
            }
        }) //end
        
        
        refOrganizations = Database.database().reference().child("organizations");
        
        refOrganizations.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0 {
                self.organizations.removeAll()
                
                for organizations in snapshot.children.allObjects as![DataSnapshot] {
                    let organizationObject = organizations.value as? [String: AnyObject]
                    let organizationName = organizationObject?["Name"]
                  //  let organizationWebsite = organizationObject?["Website"]


                    
                    let organization = OrganizationModel(Name: organizationName as! String?)
                    self.organizations.append(organization)
                }
                self.organizationContainer.reloadData()
            }
        })
        
        
        
        
        
    } // end override

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
         self.updatesVisibleSegment()
    }
    
    func updatesVisibleSegment() {
        if segmentedControl.selectedSegmentIndex == 0 {
            self.organizationContainer.isHidden = true
            self.tableContainer.isHidden = false
        } else {
            self.organizationContainer.isHidden = false
            self.tableContainer.isHidden = true
        }
    }

} //*******End Class
