//
//  ViewController.swift
//  ViewTransitions
//
//  Created by Kevin Balvantkumar Patel on 2/23/17.
//  Copyright © 2017 LZChat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    let dataSource = ["hello", "world","mercury", "venus", "earth", "mars", "jupiter", "saturn", "uranus", "neptune", "pluto", "kevin", "iOS", "swift"];
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialSetup()
    }

    func initialSetup() {
        self.mainTableView.dataSource = self
        self.mainTableView.delegate = self
        self.mainTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! DetailViewController
        destVC.dataForSelectedCell = dataSource[selectedIndexPath?.row ?? 0]
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let returnCell = tableView.dequeueReusableCell(withIdentifier: TempTableViewCell.celluniqueIdentifier, for: indexPath) as! TempTableViewCell
        
        returnCell.cellData = dataSource[indexPath.row]
        
        return returnCell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.performSegue(withIdentifier: "detail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
