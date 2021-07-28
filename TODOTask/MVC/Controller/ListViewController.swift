//
//  ViewController.swift
//  TodoList
//
//  Created by Pragati NICB on 27/07/21.
//

import UIKit
import CoreData


class ListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segIndex: UISegmentedControl!
    
    var categories = [TodoList]()
    var categoriesSec = [TodoList]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tempVar = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register( UINib(nibName: "TodoListTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoListTableViewCell")
        
        segIndex.addTarget(self, action: #selector(segmentedControlValueChangedValue), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        categoriesSec.removeAll()
        retrieveData()
        for dirC in categories{
            
            if dirC.selectIndexF == tempVar{
                categoriesSec.append(dirC)
            }
            
            tableView.reloadData()
        }
        
    }
    
    
    @objc func segmentedControlValueChangedValue(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            tempVar = 1
            categoriesSec.removeAll()
            retrieveData()
            for dirC in categories{
            if dirC.selectIndexF == tempVar{
            categoriesSec.append(dirC)
            }
            tableView.reloadData()
            }
        }
        else if sender.selectedSegmentIndex == 1 {
            tempVar = 2
            
            categoriesSec.removeAll()
            retrieveData()
            
            for dirC in categories{
            if dirC.selectIndexF == tempVar{
            categoriesSec.append(dirC)
            }
            tableView.reloadData()
            }
        }
        else if sender.selectedSegmentIndex == 2{
            tempVar = 3
            
            categoriesSec.removeAll()
            retrieveData()
            
            for dirC in categories{
            if dirC.selectIndexF == tempVar{
            categoriesSec.append(dirC)
            }
            tableView.reloadData()
            }
        }
        
    }
    
    
    @IBAction func addItem(_ sender: Any) {
        
        let  nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddTodoViewController") as!  AddTodoViewController
        
        nextVC.tempNum = Int16(tempVar)
        nextVC.updateVar = 1
        
        navigationController?.pushViewController( nextVC, animated:  true)
        
    }
    
    
    func retrieveData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoList")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            categories.removeAll()
            
            for dirC in result{
                categories.append(dirC as! TodoList)
                
            }
            
        } catch {
            
            print("Failed")
        }
        
    }
    
    
}

extension ListViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesSec.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath) as! TodoListTableViewCell
        cell.LBL_TaskName.text = categoriesSec[indexPath.row].name
        cell.BTN_Edit.addTarget( self, action: #selector(updateDataForRow), for: .touchUpInside)
        cell.BTN_Edit.tag = indexPath.row
        
        return cell
        
    }
    
    @objc func updateDataForRow(sender : UIButton){
        
        let dirC = categoriesSec[sender.tag]
        
        let  nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddTodoViewController") as!  AddTodoViewController
        
        nextVC.tempNum = Int16(tempVar)
        nextVC.dirC = dirC
        nextVC.updateVar = 2
        
        navigationController?.pushViewController( nextVC, animated:  true)
        
        
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if (editingStyle == .delete) {
            let category = categoriesSec[indexPath.row]
            categoriesSec.remove(at: indexPath.row)
            managedContext.delete(category)
            
            do {
                try managedContext.save()
            } catch {
                print("Error deleting category with \(error)")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    
}

