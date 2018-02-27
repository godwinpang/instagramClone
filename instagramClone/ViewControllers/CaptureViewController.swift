//
//  CaptureViewController.swift
//  instagramClone
//
//  Created by Godwin Pang on 2/26/18.
//  Copyright © 2018 godwinpang. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let vc = UIImagePickerController()
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionInput: UITextField!
    let postPhotoErrorAlertController = UIAlertController(title: "Photo Required", message: "Please select a photo to post", preferredStyle: .alert)
    let postCaptionErrorAlertController = UIAlertController(title: "Caption Required", message: "Please enter a caption to post", preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        //does nothing -> dismisses alert view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postPhotoErrorAlertController.addAction(OKAction)
        postCaptionErrorAlertController.addAction(OKAction)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectImage(_ sender: Any) {
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        present(vc, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        imageView.image = editedImage
        
        selectImageButton.setTitle("", for: .normal)
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    @IBAction func uploadPost(_ sender: Any) {
        if (imageView.image == nil){
            present(postPhotoErrorAlertController, animated: true)
        } else if (captionInput.text?.isEmpty)! {
            present(postCaptionErrorAlertController, animated: true)
        } else {
            Post.postUserImage(image: imageView.image, withCaption: captionInput.text, withCompletion: nil)
            imageView.image = nil
            captionInput.text = ""
            selectImageButton.setTitle("Tap to select image", for: .normal)
            super.tabBarController?.selectedIndex = 0
        }
    }
    
}
