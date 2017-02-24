//
//  DetailViewController.swift
//  ViewTransitions
//
//  Created by Kevin Balvantkumar Patel on 2/23/17.
//  Copyright © 2017 LZChat. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var dataForSelectedCell: String?
    
    
    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataLabel.text = dataForSelectedCell
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
