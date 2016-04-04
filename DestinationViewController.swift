//
//  DestinationViewController.swift
//  PlayersSwift
//
//  Created by James Rochabrun on 02-04-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

import UIKit
import CoreData


class DestinationViewController: UIViewController {
    
    //creating a property type NSManagedObject "Moc"
    var person = NSManagedObject!()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var skillLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assigning the name
        title = self.person.valueForKey("name") as? String
        
        //assigning the image
        imageView.image =  UIImage(named: (self.person.valueForKey("picture") as? String)! )
        
        //assigning the skill
        let a = "Skill:       "
        let b =  self.person.valueForKey("skill") as? String
        skillLabel.text = a + b!
        
    

        
    }

//
//    @IBAction func selectPlayer(sender: AnyObject) {
//        if  (self.person.valueForKey("selected") as? Bool == false){
//            self.person.setValue(true, forKey: "selected")
//            NSLog("i am selected")
//        } else {
//            self.person.setValue(false, forKey: "selected")
//            NSLog("i am not")
//        }
//    }
    

    
    
    
    
    
    
    
    
    
    
    
    



}
