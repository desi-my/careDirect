//
//  ResorcesVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/21/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class ResorcesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var tableContainer: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var arrow: UIImageView!
    
    @IBOutlet weak var resourcesCategories: UITextField!
    
    @IBAction func requestResAndOrg(_ sender: UIButton) {
        let mailCompose = MFMailComposeViewController()
        mailCompose.mailComposeDelegate = self
        mailCompose.setToRecipients(["request@caredirect.com"])
        mailCompose.setSubject("Request to Add a Resource or Organization")
        mailCompose.setMessageBody("Hello!  In order to submit a request to add a Resource or Organization to CareDirect, please inlcude the following info: Name, Email, Phone, Location, Website and any additional description. We will typically respond to request within 2-4 business days after recieving the request.", isHTML: false)
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mailCompose, animated: true, completion: nil)
        }else {
            print ("error!")
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    let categories = ["All", "Housing", "Education", "Health", "Immigration", "SubstanceTreatment", "Prevention"]
    
    var pickerView = UIPickerView()
    var refResources: DatabaseReference!
    var resources = [ResourcesModel]()
    var selectedResource: ResourcesModel?
    var expandedRowIndex : Int?
    
    private var dpShowWebsiteVisible = false
    private var dpShowEmailVisible = false
    private var dpShowPhoneVisible = false
    
    private var orShowWebsiteVisible = false
    private var orShowEmailVisible = false
    private var orShowPhoneVisible = false
    private var orShowLocationVisible = false
    
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
        if (categories[row] == "All") {
            refreshResourcesAll()
        }
        else {
            refreshResources(category: categories[row])
        }
        resourcesCategories.text = categories[row]
        resourcesCategories.resignFirstResponder()
    }
    
    private func toggleContent() {
        
        //        let cell = self.tableView.dequeueReusableCell(withIdentifier: "refCell", for: indexPath) as! ResourceTableViewCell
        
//        let resourceCell = cell as! ResourceTableViewCell
//        resourceCell.isExpanded = !resourceCell.isExpanded
        dpShowWebsiteVisible = !dpShowWebsiteVisible
        dpShowEmailVisible = !dpShowEmailVisible
        dpShowPhoneVisible = !dpShowPhoneVisible
        
        tableContainer.beginUpdates()
        tableContainer.endUpdates()
    }
    
    private func toggleOrgContent() {
        
//        let orgCell = cell as! OrganizationTableViewCell
//        orgCell.isExpanded = !orgCell.isExpanded
        
        orShowWebsiteVisible = !orShowWebsiteVisible
        orShowEmailVisible = !orShowEmailVisible
        orShowPhoneVisible = !orShowPhoneVisible
        orShowLocationVisible = !orShowLocationVisible
        
        organizationContainer.beginUpdates()
        organizationContainer.endUpdates()
    }
    
    //  func numberOfSections(in tableView: UITableView) -> Int {
    // return 1
    //  }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //   return organizations.count
        
        if tableView == tableContainer  {
            return resources.count
        }else {
            return organizations.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        var cell:UITableViewCell?
        
        if tableView == tableContainer {
            let cell = tableView.dequeueReusableCell(withIdentifier: "refCell", for: indexPath) as! ResourceTableViewCell
            let resource: ResourcesModel
            resource = resources[indexPath.row]
            cell.lblName.text = resource.name
            cell.lblWebsite.text = resource.website
            cell.lblEmail.text = resource.email
            cell.lblPhone.text = resource.phone
            return cell
        } else {
            let orgCell = tableView.dequeueReusableCell(withIdentifier: "orgCell", for: indexPath) as! OrganizationTableViewCell
            let organization: OrganizationModel
            organization = organizations[indexPath.row]
            orgCell.lblName.text = organization.name
            orgCell.lblLocation.text = organization.location
            orgCell.lblPhone.text = organization.phone
            orgCell.lblEmail.text = organization.email
            orgCell.lblWebsite.text = organization.website
            return orgCell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView == tableContainer {
            // RESOURCES
    
            if expandedRowIndex == indexPath.row {
                let resourceCell = tableView.cellForRow(at: indexPath) as! ResourceTableViewCell
                let siteString = resourceCell.lblWebsite.text
                let siteURL = URL(string: siteString!)
                UIApplication.shared.open(siteURL!)
            }
            
            let indexPath = tableContainer.indexPathForSelectedRow!
            toggleContent()
            tableContainer.deselectRow(at: indexPath, animated: true)
            selectedResource = resources[indexPath.row]
            expandedRowIndex = indexPath.row
            
        } else {
            // ORGANIZATIONS
            
            
            if expandedRowIndex == indexPath.row {
                let orgCell = tableView.cellForRow(at: indexPath) as! OrganizationTableViewCell
                let siteString = orgCell.lblWebsite.text
                let siteURL = URL(string: siteString!)
                UIApplication.shared.open(siteURL!)
            }
            
            let indexPath = organizationContainer.indexPathForSelectedRow!
            selectedPath = organizations[indexPath.row]
            toggleOrgContent()
            organizationContainer.deselectRow(at: indexPath, animated: true)
            
            expandedRowIndex = indexPath.row
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == tableContainer {
            if  indexPath == tableContainer.indexPathForSelectedRow {
                //        if dpShowWebsiteVisible{           //on click hide and show all cells
                return ResourceTableViewCell.expandedHeight
            } else {
                return ResourceTableViewCell.defaultHeight
            }
        }else if (tableView == organizationContainer) {
            if  (indexPath == organizationContainer.indexPathForSelectedRow) {
                return OrganizationTableViewCell.expandedHeightOrg
            } else {
                return OrganizationTableViewCell.defaultHeightOrg
            }
        } else {
            return OrganizationTableViewCell.defaultHeightOrg
        }
        
        
    }
    
    func refreshResources(category: String) {
        
        refResources.queryOrdered(byChild: "Name").observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0 {
                self.resources.removeAll()
                
                for resources in snapshot.children.allObjects as![DataSnapshot] {
                    let resourceObject = resources.value as? [String: AnyObject]
                    if (resourceObject!["category" + category] != nil) {
                        let resourceName = resourceObject?["Name"]
                        let resourceWebsite = resourceObject?["Website"]
                        let resourceEmail = resourceObject?["Email"]
                        let resourcePhone = resourceObject?["Phone"]
                        let resourceLocation = resourceObject?["Location"]
                        
                        let resource = ResourcesModel(Name: resourceName as! String?, Website: resourceWebsite as! String?, Email: resourceEmail as! String?, Phone: resourcePhone as! String?, Location: resourceLocation as! String?)
                        self.resources.append(resource)
                    }
                }
                self.tableContainer.reloadData()
            }
        }) //end
        
    }
    
    func refreshResourcesAll() {
        refResources.queryOrdered(byChild: "Name").observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0 {
                self.resources.removeAll()
                
                for resources in snapshot.children.allObjects as![DataSnapshot] {
                    let resourceObject = resources.value as? [String: AnyObject]
                    let resourceName = resourceObject?["Name"]
                    let resourceWebsite = resourceObject?["Website"]
                    let resourceEmail = resourceObject?["Email"]
                    let resourcePhone = resourceObject?["Phone"]
                    let resourceLocation = resourceObject?["Location"]
                    
                    
                    
                    let resource = ResourcesModel(Name: resourceName as! String?, Website: resourceWebsite as! String?, Email: resourceEmail as! String?, Phone: resourcePhone as! String?, Location: resourceLocation as! String?)
                    self.resources.append(resource)
                    
                }
                self.tableContainer.reloadData()
            }
        }) //end
        
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
        refreshResourcesAll();
        
        refOrganizations = Database.database().reference().child("organizations");
        
        refOrganizations.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0 {
                self.organizations.removeAll()
                
                for organizations in snapshot.children.allObjects as![DataSnapshot] {
                    let organizationObject = organizations.value as? [String: AnyObject]
                    let organizationName = organizationObject?["Name"]
                    let organizationLocation = organizationObject?["Location"]
                    let organizationWebsite = organizationObject?["Website"]
                    let organizationEmail = organizationObject?["Email"]
                    let organizationPhone = organizationObject?["Phone"]
                    
                    let organization = OrganizationModel(Name: organizationName as! String?, Website: organizationWebsite as! String?, Email: organizationEmail as! String?, Phone: organizationPhone as! String?, Location: organizationLocation as! String? )
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
        expandedRowIndex = nil
        if segmentedControl.selectedSegmentIndex == 0 {
            self.organizationContainer.isHidden = true
            self.tableContainer.isHidden = false
            self.resourcesCategories.isHidden = false
            self.arrow.isHidden = false
        } else {
            self.organizationContainer.isHidden = false
            self.tableContainer.isHidden = true
            self.resourcesCategories.isHidden = true
            self.arrow.isHidden = true
        }
    }
    
} //*******End Class
