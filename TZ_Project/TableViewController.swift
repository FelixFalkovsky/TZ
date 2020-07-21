//
//  TableViewController.swift
//  TZ_Project
//
//  Created by Felix Falkovsky on 20.07.2020.
//  Copyright © 2020 Felix Falkovsky. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData {
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTZ.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let dataTZpost = dataTZ[indexPath.row]
      
        cell.textLabel?.text = dataTZpost.data
        cell.detailTextLabel?.text = dataTZpost.name
      
       
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToOneTest", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToOneTest" {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as? OneTestViewController)?.dataDZ = dataTZ[indexPath.row]
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}
