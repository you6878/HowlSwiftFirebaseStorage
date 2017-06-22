//
//  UserController.swift
//  HowlFireBaseLogin
//
//  Created by 유명식 on 2017. 6. 17..
//  Copyright © 2017년 swift. All rights reserved.
//

import UIKit
import Firebase

class UserController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBAction func logout(_ sender: Any) {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch  {
            
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func profileUpload(_ sender: Any) {
        
        let imagePick = UIImagePickerController()
        imagePick.delegate = self
        imagePick.allowsEditing = true
        imagePick.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imagePick, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage)
        
        let imageName = FIRAuth.auth()!.currentUser!.uid + "\(Int(NSDate.timeIntervalSinceReferenceDate * 1000)).jpg"
        
        let riversRef = FIRStorage.storage().reference().child("ios_images").child(imageName)
        
        riversRef.put(image!, metadata: nil) { metadata, error in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL
            }
        }
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
