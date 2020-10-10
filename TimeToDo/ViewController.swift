//
//  ViewController.swift
//  TimeToDo
//
//  Created by Hakim Laoukili on 2020-10-05.
//  Copyright © 2020 Hakim Laoukili. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var tabelView: UITableView!
    
    var tasks = [String()]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        tabelView.delegate = self
        tabelView.dataSource = self
        
        //Setup
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true,forKey: "setup")
            UserDefaults().set(0,forKey: "count")
        }
        //Get all current saved Tasks
       updateTasks()
    }
    // Safes current tasks
   
    func updateTasks(){
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        for x in 0..<count{
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
         tabelView.reloadData()
        
    }
    @IBAction func didTapAdd() {
        
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "Add New To Do"
        vc.update = {
            DispatchQueue.main.async {
                 self.updateTasks()
                
            }
            
           
            
        }
        navigationController?.pushViewController(vc, animated: true)
               
           }

}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)
    }
    
    
}
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    
}


