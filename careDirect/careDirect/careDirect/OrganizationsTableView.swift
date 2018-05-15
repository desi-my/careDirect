//
//  OrganizationsTableView.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/22/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit

class OrganizationsTableView: UITableView,  UITableViewDelegate, UITableViewDataSource {
    
    

    // Organization List
    @IBOutlet weak var organizationContainer: UITableView!
    var organizations = [OrganizationModel]()
    var selectedPath: OrganizationModel?
    var   refOrganizations: DatabaseReference!
    
    
    
    
    
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
        return (resources.count + organizations.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        
        
        
        if tableContainer == self.tableContainer {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "refCell", for: indexPath) as! ResourceTableViewCell
            
            let resource: ResourcesModel
            resource = resources[indexPath.row]
            cell.lblName.text = resource.name
            cell.lblWebsite.text = resource.website
            cell.lblEmail.text = resource.email
            cell.lblPhone.text = resource.phone
            return cell
        }
        else
            if organizationContainer == self.organizationContainer {
                let orgCell = tableView.dequeueReusableCell(withIdentifier: "orgCell", for: indexPath) as! OrganizationTableViewCell
                
                let organization: OrganizationModel
                organization = organizations[indexPath.row]
                orgCell.lblName.text = organization.name
                return orgCell
                
        }
        
        return
        
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
            //   if dpShowWebsiteVisible{           //on click hide and show all cells
            return ResourceTableViewCell.expandedHeight
        } else {
            return ResourceTableViewCell.defaultHeight
        }
    }
    
    //end test
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updatesVisibleSegment()
        
     
        
        
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
    

} //*******End Class

