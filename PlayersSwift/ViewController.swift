//
//  ViewController.swift
//  PlayersSwift
//
//  Created by James Rochabrun on 02-04-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController,UITableViewDataSource {
    
    var people = [NSManagedObject]()
    var thumbnails = ["neymar","messi","falcao","cavanni","ribery","rooney", "iniesta","pirlo","ronaldo"]

    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\"Players\""
        
        //this go if I need just a normal cell
//        tableView.registerClass(UITableViewCell.self,
//            forCellReuseIdentifier: "CellId")
     
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return people.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {

            //cell detail fix
            //http://stackoverflow.com/questions/34101102/uitableviewcell-detailtextlabel-not-showing-up
            
            var cell = tableView.dequeueReusableCellWithIdentifier("CellId") as UITableViewCell!
            
            if cell == nil {
                cell = UITableViewCell(style: .Value1, reuseIdentifier: "CellId")
            }
            
            let person = self.people[indexPath.row]
            
            //assigning the value from the first textfield to the name attribute
            cell!.textLabel!.text = person.valueForKey("name") as? String
            
            //assigning the value of the second textfield to the skill attribute
            cell!.detailTextLabel?.text = person.valueForKey("skill") as? String
            
            //assigning the image form coredata
            let imageName = person.valueForKey("picture") as? String
            let image = UIImage(named:imageName!)
            cell?.imageView!.image = image

            
            //debugging
            let skill = person.valueForKey("skill") as? String
            NSLog("\(skill)")
            NSLog("\(imageName)")

            
            return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //setting the cell
        var cell = tableView.dequeueReusableCellWithIdentifier("CellId")
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "CellId")
        }
        
        //now the managedObject
        let person = self.people[indexPath.row]
        
        cell!.textLabel!.text = person.valueForKey("name") as? String
        
        //assigning the value of the second textfield to the skill attribute
        cell!.detailTextLabel?.text = person.valueForKey("skill") as? String
        
        //assigning the image form coredata
        let imageName = person.valueForKey("picture") as? String
        let image = UIImage(named:imageName!)
        cell?.imageView!.image = image
        
        //checking condition
        
        if  (person.valueForKey("selected") as? Bool == true){
            cell!.backgroundColor = UIColor.brownColor()
            NSLog("i am selected")
        }
        
    }
    
    @IBAction func addPlayerinformation(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Name",
            message: "Add a new name",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default,
            handler: { (action:UIAlertAction) -> Void in
                
                //name
                let textField = alert.textFields!.first
                //skill
                let textField1 = alert.textFields!.last
                
                //sending a random image  for the player 
                
                let arrayCount = UInt32(self.thumbnails.count)
                let unsignedRandomNumber = arc4random_uniform(arrayCount)
                let randomNumber = Int(unsignedRandomNumber)
                let pictureName = self.thumbnails[randomNumber]
                
                //sending information of the player to coredata
                self.saveInformation(textField!.text!, skill :textField1!.text!,picture: pictureName)
                
                //sending the skill to core data with this function
                
                
                self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in

        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField1: UITextField) -> Void in
            
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
    }


    //sending data to the staging area first the name
    
    func saveInformation(name: String, skill: String, picture: String) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Person",
            inManagedObjectContext:managedContext)
        
        let person = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        //3
        
        //assigning the attributes 
        // saveInformation is called in the save action of the alert controller
        person.setValue(name, forKey: "name")
        person.setValue(skill, forKey: "skill")
        person.setValue(picture, forKey: "picture")
        
        //setting the selected attribute to false
        //person.setValue(false, forKey: "selected")

        
        //4
        do {
            try managedContext.save()
            //5
            people.append(person)
            
            //debuging
            NSLog("\(people.count)")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    

    
    
    //pulling the data form the staging area
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        //3
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            self.people = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    
    //creating the prepare for segue 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
        let cell = sender as! UITableViewCell
        
        let indexPath = tableView.indexPathForCell(cell)
 
        let player = self.people[indexPath!.row]
        
        let desVc = segue.destinationViewController as? DestinationViewController
       
        desVc?.person = player
        
            
        
    }

    
    
    
    
    
    
    
}



















