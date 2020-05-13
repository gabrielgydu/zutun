//
//  AddTaskViewController.swift
//  zutun
//
//  Created by Gabriel Schütz on 31.05.17.
//  Copyright © 2017 Gabriel Schütz. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var tasktTitleTextField: UITextField!
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    
    @IBOutlet weak var selectedDateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tasktTitleTextField.delegate = self
        
    }

    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //Hide keyboard
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        taskTitleLabel.text = textField.text
    }
    //MARK: Actions
    
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        taskTitleLabel.text = "Default Task"
    }

    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.unitsStyle = .full
        //dateFormatter.allowedUnits = [.weekday, .day, .month, .hour, .minute]
        selectedDateLabel.alpha = 1.0
        if let outputString = dateFormatter.string(for: sender.date.description){
            selectedDateLabel.text = outputString
        }
        

    }

}

