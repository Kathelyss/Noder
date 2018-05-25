//
//  ViewController.swift
//  Noder
//
//  Created by Екатерина Рыжова on 23.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet var indexTextField: NSTextField!
    @IBOutlet var nameTextField: NSTextField!
    @IBOutlet var xTextField: NSTextField!
    @IBOutlet var yTextField: NSTextField!
    @IBOutlet var floorTextField: NSTextField!
    @IBOutlet var connectionNodeTextField: NSTextField!
    @IBOutlet var edgeLength: NSTextField!
    @IBOutlet var edgeWeight: NSTextField!
    
    @IBOutlet var tableView: NSTableView!
    
    @IBAction func tapAddNode(_ sender: NSButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

