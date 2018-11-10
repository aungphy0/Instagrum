//
//  HomeViewController.swift
//  Instagrum
//
//  Created by AUNG PHYO on 11/7/18.
//  Copyright © 2018 AUNG PHYO. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var homePosts : [PFObject]!
    
    @IBAction func logoutButon(_ sender: Any) {
        PFUser.logOutInBackground(block : { (error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                print("User Logout Successfully")
                self.performSegue(withIdentifier: "loginViewSegue", sender: nil)
            }
        })
    }
    
    
    @IBAction func cameraButton(_ sender: Any) {
       performSegue(withIdentifier: "cameraSegue", sender: nil)
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.rowHeight = 350
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Refresh posts from Parse each time the user visits this view controller since new posts
        // might have been added in PhotoCaptureViewController. An alternative would be to use
        // NSNotificationCenter or a subclass of UITabBarController to communicate between view
        // controllers when a new post is added, but this might be too much to go over in this
        // assignment.
        self.getPostsFromParse()
    }
    
    func getPostsFromParse(){
        print("Retrieving...")
        
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("created_at")
        query.includeKey("photo")
        
        query.findObjectsInBackground { (results: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let results = results {
                    print("Successfully retrieved \(results.count) posts")
                    self.homePosts = results
                    self.tableView.reloadData()
                }else{
                    print("no data")
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homePosts == nil ? 0 : self.homePosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homePosts", for: indexPath) as! HomeTableViewCell
        cell.homePost = homePosts[indexPath.row]
        
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
