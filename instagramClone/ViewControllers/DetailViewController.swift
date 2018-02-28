//
//  DetailViewController.swift
//  instagramClone
//
//  Created by Godwin Pang on 2/27/18.
//  Copyright © 2018 godwinpang. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {
    
    var post: PFObject?

    @IBOutlet weak var imageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.file = post!["media"] as? PFFile
        self.captionLabel.text = post!["caption"] as? String
        let createDate = post?.createdAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from:createDate as! Date)
        self.timestampLabel.text = dateString
        self.imageView.loadInBackground()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
