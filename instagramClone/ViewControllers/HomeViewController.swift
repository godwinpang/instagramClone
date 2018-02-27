//
//  HomeViewController.swift
//  instagramClone
//
//  Created by Godwin Pang on 2/26/18.
//  Copyright © 2018 godwinpang. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    var posts: [Post]? = []
    var refreshControl: UIRefreshControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        refresh()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = self.posts?[indexPath.row]
        if (post?.author) != nil {
            cell.instagramPost = post
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    @objc func refresh(){
        let query = PFQuery(className: "Post")
        query.includeKey("author")
        query.addDescendingOrder("createdAt")
        query.limit = 20
        
        query.findObjectsInBackground{ (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.posts = posts as? [Post]
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                print("\(String(describing: error?.localizedDescription))")
            }
        }
        
    }
}
