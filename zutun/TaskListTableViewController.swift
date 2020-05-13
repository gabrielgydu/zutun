//
//  TaskListTableViewController.swift
//  zutun
//
//  Created by Gabriel Schütz on 01.06.17.
//  Copyright © 2017 Gabriel Schütz. All rights reserved.
//

import UIKit
import os.log

class TaskListTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var list: TaskList?
    var lists: [TaskList]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list?.tasks.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = list?.tasks[indexPath.row]
        let dequeued = tableView.dequeueReusableCell(withIdentifier: "TaskListTableViewCell", for: indexPath)
        
        if let cell = dequeued as? TaskListTableViewCell {
            dequeued.textLabel?.text = data?.taskName
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
            // Delete the row from the data source
            list?.tasks.remove(at: indexPath.row)
            saveList()
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
        
        if let identifier = segue.identifier {
            switch identifier {
                case "ShowDetail":// Show detail information and allow editing for an existing task
                    if let cell = sender as? TaskListTableViewCell,
                        let indexPath = tableView.indexPath(for: cell),
                        let taskDetail = segue.destination as? TaskDetailTableViewController{
                        taskDetail.title = "Detail"
                        taskDetail.task = list?.tasks[indexPath.row]
                }
                
                case "AddTask":// Create a new task item, to be edited by the Detail Screen
                    //Set Detail title to "New Task"
                    break
                default: break
            }
        }
        
    }
    
    //MARK: Actions
    
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? TaskDetailTableViewController,
            let task = sourceViewController.task {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing task.
                list?.tasks[selectedIndexPath.row] = task
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new task.
                let newIndexPath = IndexPath(row: (list?.tasks.count)!, section: 0)
                list?.tasks.append(task)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    
    //MARK: Private Methods
    
    // Should this be private? Shouldn't this be in the Model?
    
    func saveList(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(lists!, toFile: TaskList.ArchiveURL.path)
        if isSuccessfulSave {
            let toFile = TaskList.ArchiveURL.path
            print(toFile)
            
            os_log("Lists successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save lists...", log: OSLog.default, type: .error)
        }
    }
    

}
