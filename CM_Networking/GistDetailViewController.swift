//
//  GistDetailViewController.swift
//  CM_Networking
//
//  Created by AlexanderYakovenko on 8/26/17.
//  Copyright © 2017 AlexanderYakovenko. All rights reserved.
//

import UIKit

class GistDetailViewController: UIViewController {

    var detailItem: Gist? {
        didSet {
            self.configureView()
        }
    }
    func configureView() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
