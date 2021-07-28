//
//  AddTodoViewController.swift
//  TodoList
//
//  Created by Pragati NICB on 27/07/21.
//

import UIKit
import CoreData

class AddTodoViewController: UIViewController {
    
    @IBOutlet weak var TXT_addText: UITextField!
    @IBOutlet weak var TXT_Desc: UITextView!
    @IBOutlet weak var BTN_ADD: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var tempNum = Int16()
    var updateVar = Int()
    
    var dirC = TodoList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if updateVar == 2 {
            
            TXT_addText.text = dirC.name ?? ""
            TXT_Desc.text = dirC.desc ?? ""
            
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        TXT_Desc.layer.borderWidth = 1
        TXT_Desc.layer.borderColor = UIColor.lightGray.cgColor
        if updateVar == 2{
            BTN_ADD.setTitle( "UPDATE", for: .normal)
        }
        else{
            BTN_ADD.setTitle( "ADD", for: .normal)
        }
        
    }
    
    
    func createData(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let newItem = TodoList(context: self.context)
        
        newItem.name = TXT_addText.text!
        newItem.desc = TXT_Desc.text
        newItem.selectIndexF = tempNum
        
        do {
            try managedContext.save()
            navigationController?.popViewController(animated: true)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func updateData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "TodoList")
        fetchRequest.predicate = NSPredicate(format:"name = %@", "\(dirC.name ??  "Na")")
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(TXT_addText.text!, forKey: "name")
            objectUpdate.setValue(TXT_Desc.text!, forKey: "desc")
            objectUpdate.setValue(tempNum, forKey: "selectIndexF")
            
            do{
                try managedContext.save()
                navigationController?.popViewController(animated: true)
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
        
    }
    
    
    @IBAction func addTaskAct(_ sender: Any) {
        
        
        if TXT_addText.text != ""{
            
            if updateVar == 2 {
                updateData()
                
            }else{
                
                createData()
                
            }
            
        }else{
            
            let alert = UIAlertController(title: "TODO List", message: "Please Add Task.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}
