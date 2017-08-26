//
//  GistsTableViewController.swift
//  CM_Networking
//
//  Created by AlexanderYakovenko on 8/26/17.
//  Copyright © 2017 AlexanderYakovenko. All rights reserved.
//

import UIKit

class GistsTableViewController: UITableViewController {

    var gists = [Gist]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGists()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadGists() {
        GitHubAPIManager.sharedInstance.fetchPublicGists() { result in
            guard result.error == nil else {
                return
            }
            
            if let fetchedGists = result.value {
                self.gists = fetchedGists
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
        
        
        /*
        let gist1 = Gist()
        gist1.description = "The first gist"
        gist1.ownerLogin = "gist1Owner"
        let gist2 = Gist()
        gist2.description = "The second gist"
        gist2.ownerLogin = "gist2Owner"
        let gist3 = Gist()
        gist3.description = "The third gist"
        gist3.ownerLogin = "gist3Owner"
        gists = [gist1, gist2, gist3]
        // Tell the table view to reload self.tableView.reloadData()
        */
        
    }
    func handleLoadGistError(_ error: Error) {
        
    }
    
    
    // showGistDetail 
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gists.count
    }
    
    
    
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let gist = self.gists[indexPath.row]
        cell.textLabel?.text = gist.description
        cell.detailTextLabel?.text = gist.ownerLogin
        
        

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.gists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGistDetail" {
            if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
                let gist = self.gists[selectedIndexPath.row]
                if let gistDetailVC = segue.destination as?  GistDetailViewController {
                    gistDetailVC.detailItem = gist
                }
            }
        }
        
       
    }
    

}
