//
//  ViewController.swift
//  Noder
//
//  Created by Екатерина Рыжова on 23.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet var nameTextField: NSTextField!
    @IBOutlet var xTextField: NSTextField!
    @IBOutlet var yTextField: NSTextField!
    @IBOutlet var floorTextField: NSTextField!
    
    @IBOutlet var tableView: NSTableView!
    
    let fileProcessor = FileProcessor(fileName: "nodes.plist")
    var nodes: [Node] = []
    
    @IBAction func tapAddNode(_ sender: NSButton) {
        reloadNodes()
        if let node = createNode() {
            nodes.append(node)
            fileProcessor.setNodes(array: nodes)
            tableView.reloadData()
        } else {
            print("Error! No needed data to add node")
        }
    }
    
    @IBAction func tapDeleteLastNodeButton(_ sender: NSButton) {
        if var storedNodes = fileProcessor.getNodes() {
            storedNodes.removeLast()
            fileProcessor.setNodes(array: storedNodes)
            reloadNodes()
        }
    }

    
    func createNode() -> Node? {
        let name = nameTextField.stringValue
        let coordX = xTextField.doubleValue
        let coordY = yTextField.doubleValue
        let floor = floorTextField.intValue
        guard name != "", coordX != 0, coordY != 0, floor != 0 else {
            print("Error! No needed data to create node")
            return nil
        }
        
        return Node(name: name, coordinates: Point(x: CGFloat(coordX), y: CGFloat(coordY)), floor: Int(floor))
    }
    
    func reloadNodes() {
        if let storedNodes = fileProcessor.getNodes() {
            nodes = storedNodes
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadNodes()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
}

extension ViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return nodes.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let item = (nodes)[row]
        let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView
        cell?.textField?.stringValue = item.description
        return cell
    }
}

extension ViewController: NSTableViewDelegate {

}
