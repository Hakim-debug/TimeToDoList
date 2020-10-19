//
//  EntryViewController.swift
//  TimeToDo
//
//  Created by Hakim Laoukili on 2020-10-06.
//  Copyright © 2020 Hakim Laoukili. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet var field: UITextField!
    
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTasks))
        // Do any additional setup after) loading the view.
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveTasks()
        
        return true
    }
    //Saves the task to the List
    @objc func saveTasks(){
        guard let text = field.text, !text.isEmpty else {
            
            return
        }

        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
       
        navigationController?.popViewController(animated: true)
         update?()
    }
}
