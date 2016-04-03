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
    var people = NSManagedObject!()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var skillLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assigning the name
        title = people.valueForKey("name") as? String
        
        //assigning the image
        imageView.image =  UIImage(named: (people.valueForKey("picture") as? String)! )
        
        //assigning the skill
        let a = "Skill:       "
        let b =  people.valueForKey("skill") as? String
        skillLabel.text = a + b!
        
    }



    

    
    
    
    
    
    
    
    
    
    
    
    



}
