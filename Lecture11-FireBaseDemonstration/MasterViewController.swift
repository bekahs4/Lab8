//
//  MasterViewController.swift
//  Lecture11-FireBaseDemonstration
//
//  Created by Jonathan Engelsma on 6/7/16.
//  Copyright © 2016 Jonathan Engelsma. All rights reserved.
//

import UIKit
import Firebase

protocol MasterDelegate {
    func setNewEntry(name:String)
}

class MasterViewController: UITableViewController, MasterDelegate {

    var detailViewController: DetailViewController? = nil
    
    var objects = [MyDateEntry]()

    var ref : FIRDatabaseReference?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        self.ref = FIRDatabase.database().reference()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.ref!.child("my-entries").observeEventType(.Value, withBlock: { snapshot in
            var newEntries = [MyDateEntry]()
            if let postDict = snapshot.value as? [String : AnyObject] {
                for (key,val) in postDict.enumerate() {
                    print("key = \(key) and val = \(val)")
                    let entry = MyDateEntry(snapshot: val.1 as! Dictionary<String,AnyObject>)
                    newEntries.append(entry)
                }
                self.objects = newEntries
                self.tableView.reloadData()
            }
        })
    }

    func setNewEntry(name:String) {
        // create a new MyDateEntry object
        let entry = MyDateEntry(name: name, status: false)
        // save in FireBase
        self.ref?.child("my-entries").child(entry.name).setValue(entry.toAnyObject())
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Segues


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "show" { 
            let controller = segue.destinationViewController as! DetailViewController
            controller.delegate = self
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let object = objects[indexPath.row]
        cell.textLabel!.text = object.name
        
        // load the check marks
        if object.status == true {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }


    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let entry = self.objects[indexPath.row]
            self.ref?.child("my-entries").child(entry.name).removeValue()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let entry = self.objects[indexPath.row]
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .Checkmark {
                cell.accessoryType = .None
                self.ref?.child("my-entries").child(entry.name).child("status").setValue(false)
            } else {
                cell.accessoryType = .Checkmark
                self.ref?.child("my-entries").child(entry.name).child("status").setValue(true)
            }
        }
    }
    
    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = UITableView[indexPath.row]
        
        let entry = self.objects[indexPath.row]
        if self.ref?.child("my-entries").child(entry.name).child("status") == false {
            self.ref?.child("my-entries").child(entry.name).child("status").setValue(true)
        } else {
            self.ref?.child("my-entries").child(entry.name).child("status").setValue(false)
        }
        
        if self.ref?.child("my-entries").child(entry.name).child("status") == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
    }
 */


//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            objects.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }


}

