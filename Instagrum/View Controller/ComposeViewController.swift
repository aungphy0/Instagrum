//
//  ComposeViewController.swift
//  Instagrum
//
//  Created by AUNG PHYO on 11/7/18.
//  Copyright © 2018 AUNG PHYO. All rights reserved.
//

import UIKit
import Parse

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var toPostPhoto : UIImage!
    
    @IBOutlet weak var previewImage: UIImageView!
    
    @IBOutlet weak var captionField: UITextField!
    
    
    @IBAction func cancelButton(_ sender: Any) {
        performSegue(withIdentifier: "cancelSegue", sender: nil)
    }
    
    
    @IBAction func shareButton(_ sender: Any) {
        let scaledImage = self.resize(image: self.toPostPhoto, newSize: CGSize(width : 750, height : 750))
        let imageData = UIImageJPEGRepresentation(scaledImage, 0)
        let imageFile = PFFile(name: "image.jpg", data: imageData!)
        
        let photo = PFObject(className: "Photo")
        photo["image"] = imageFile
        
        let post = PFObject(className: "Post")
        post["user"] = PFUser.current()
        post["photo"] = photo
        post["caption"] = self.captionField.text
        
        post.saveInBackground{ (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                print("Post saved successfully!")
                self.performSegue(withIdentifier: "cancelSegue", sender: nil)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cameraOption(_ sender: UITapGestureRecognizer) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        self.toPostPhoto = originalImage
        self.previewImage.image = self.toPostPhoto
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x:0, y:0, width:newSize.width, height:newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
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
