//
//  AddEventVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 2/26/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
//import FirebaseAuth

class AddEventVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var refEvents: DatabaseReference!
    
    @IBOutlet weak var titleEventTF: UITextField!
    @IBOutlet weak var locationEventTF: UITextField!
    @IBOutlet weak var websiteTF: UITextField!
    @IBOutlet weak var organizationEvent: UITextField!
    @IBOutlet weak var descriptionEventTF: UITextView!
    @IBOutlet weak var dateEvent: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    //  @IBOutlet weak var titleEventTF: UITextField!
  //  @IBOutlet weak var locationEventTF: UITextField!
   // @IBOutlet weak var descriptionEventTF: UITextView!
   // @IBOutlet weak var websiteTF: UITextField!
  //  @IBOutlet weak var dateEvent: UITextField!
  //  @IBOutlet weak var organizationEvent: UITextField!
 //   @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose an Image", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    
    //pick date
    let picker = UIDatePicker()
    
    @IBAction func addEventTapped(_ sender: UIButton) {
        addEvent()
    }
    
    
    func createDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        dateEvent.inputAccessoryView = toolbar
        dateEvent.inputView = picker
    }

    
    @objc func donePressed() {
        //format date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let dateString = formatter.string(from: picker.date)
        
        dateEvent.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createDatePicker()
        refEvents = Database.database().reference().child("events");
    }
    
    
    func addEvent(){
        let key = refEvents.childByAutoId().key
        
        let event = ["Title": titleEventTF.text! as String,
                     "Location": locationEventTF.text! as String,
                     "Description": descriptionEventTF.text! as String,
                     "Website": websiteTF.text! as String,
                     "Date": dateEvent.text! as String,
                    "Organization": organizationEvent.text! as String
                     ]
        
        refEvents.child(key).setValue(event)
        
       
        
      /*  //Save images to the storage  -----   1

        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("\(imageName).png")
        
        if let uploadData = UIImagePNGRepresentation(imageView.image!){
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error as Any)
                   return
                }
                print(metadata as Any)
            })
        }   */
        
        
        //Save images to the storage  -- --- - -2
  /*      func uploadProfilePic(){
            var data = NSData()
            data = UIImageJPEGRepresentation(imageView.image!, 0.8)! as NSData
            // set upload path
            let filePath = "\(event)" // path where you wanted to store img in storage
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            
            let storageRef = Storage.storage().reference()
            storageRef.child(filePath).putData(data as Data, metadata: metaData){(metaData,error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }else{// store imageURL in DB.
                    let dbfilePath = "\(event)/userpic" // update db userpic link.
                    //store downloadURL
                    let downloadURL = metaData!.downloadURL()!.absoluteString
                    //store downloadURL at database
                    self.refEvents.child(dbfilePath).updateChildValues(["userPic" : downloadURL])
                }
            }
            
        }    */
     
    
        
   //Save images to the storage  ----- it works
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
         let imageName = NSUUID().uuidString
         let storageRef = Storage.storage().reference().child("\(imageName).png")
        
        if let uploadData = UIImagePNGRepresentation(imageView.image!)  {
         storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
         if error != nil {
         print(error as Any)
         return
         }
             print(metadata as Any)
            let downloadURL = metadata?.downloadURL()?.absoluteString
            self.refEvents.child(key).child("URL").setValue(downloadURL)
            
         })
         }
        
        
        // Image Storage  worked perfect
         /*  var data = NSData()
           data = UIImagePNGRepresentation(imageView.image!)! as NSData

            let metaData = StorageMetadata()
            metaData.contentType = "image/png"
            
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("\(imageName).png")
          
            storageRef.putData(data as Data, metadata: metaData){(metaData,error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }else{
                    //store downloadURL
                    let downloadURL = metaData!.downloadURL()!.absoluteString
                    //store downloadURL at database
                      self.refEvents.child(key).child("URL").setValue(downloadURL)
                }
            
            }  */
      
        
        
        
        
        
        
        
 
        
    }   // end addEvent

 /*   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }    */
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }

    
    
    
} // end
