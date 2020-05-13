//
//  ListsTableViewController.swift
//  zutun
//
//  Created by Gabriel Schütz on 01.06.17.
//  Copyright © 2017 Gabriel Schütz. All rights reserved.
//

import UIKit
import os.log

class ListsTableViewController: UITableViewController {
    
    var lists = [TaskList]()
    
    private func loadSampleData() {
        
        guard let task1 = Task(taskName: "Read UMC Article", taskDescription: "Article available in Moodle", isCompleted: false, hasReminder: false) else {
            fatalError("Unable to instantiate taskl1")
        }
        
        guard let task2 = Task(taskName: "Post on UMC Forum", taskDescription: " ", isCompleted: false, hasReminder: false) else {
            fatalError("Unable to instantiate taskl2")
        }
        
        guard let task3 = Task(taskName: "Send UMC Task", taskDescription: "Make a 1 page description of the article", isCompleted: false, hasReminder: false) else {
            fatalError("Unable to instantiate taskl3")
        }
        
        
        guard let list1 = TaskList(title: "University", tasks: [task1, task2, task3]) else {
            fatalError("Unable to instantiate list1")
        }
        guard let list2 = TaskList(title: "School", tasks: []) else {
            fatalError("Unable to instantiate list2")
        }
        guard let list3 = TaskList(title: "Work", tasks: []) else {
            fatalError("Unable to instantiate list3")
        }
        
        lists += [list1, list2, list3]
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedLists = loadLists() {
            lists += savedLists
        }else{
            loadSampleData()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.endIndex
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = lists[indexPath.row]
        let dequeued = tableView.dequeueReusableCell(withIdentifier: "ListsTableViewCell", for: indexPath)
        
        if let cell = dequeued as? ListsTableViewCell {
            dequeued.textLabel?.text = data.title
            return cell
        }else{
        return dequeued
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            lists.remove(at: indexPath.row)
            saveLists()
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier{
            if identifier == "ShowTaskList"{
                if let cell = sender as? ListsTableViewCell,
                    let indexPath = tableView.indexPath(for: cell),
                    let seguedToMVC = segue.destination as? TaskListTableViewController{
                    seguedToMVC.title = cell.textLabel?.text!//Selected list's name as the TaskList screen's title
                    seguedToMVC.list = self.lists[indexPath.row]
                    seguedToMVC.lists = self.lists
                }
            }
        }
    }
    
    //MARK: Actions
    
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NewListTableViewController,
            let list = sourceViewController.list {
            
                // Add a new list.
            let newIndexPath = IndexPath(row: lists.count, section: 0)
                
            lists.append(list)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
            // Save the lists.
            saveLists()
        }
    }
    
    //MARK: Private Methods
    
    // Should this be private? Shouldn't this be in the Model?
    func saveLists(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(lists, toFile: TaskList.ArchiveURL.path)
        if isSuccessfulSave {
            let toFile = TaskList.ArchiveURL.path
            print(toFile)
            
            os_log("Lists successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save lists...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadLists() -> [TaskList]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: TaskList.ArchiveURL.path) as? [TaskList]
    }

}
