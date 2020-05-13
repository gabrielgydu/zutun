//
//  NewListTableViewController.swift
//  zutun
//
//  Created by Gabriel Schütz on 03.06.17.
//  Copyright © 2017 Gabriel Schütz. All rights reserved.
//

import UIKit

class NewListTableViewController: UITableViewController, UITextFieldDelegate {

    
    var list: TaskList?
    
    @IBOutlet weak var listTitle: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTitle.delegate = self
        
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide keyboard
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        
        
        //TODO check this
        /*taskName.text = textField.text
         task?.taskName = textField.text!*/
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    // MARK: - Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? UIBarButtonItem,
            button === saveButton{
            let title = listTitle.text ?? ""
            list = TaskList(title: title, tasks: [])
        }

    }
    
    // MARK: Private methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = listTitle.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}
