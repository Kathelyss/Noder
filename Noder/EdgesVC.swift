//
//  EdgesVC.swift
//  Noder
//
//  Created by Екатерина Рыжова on 29.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Cocoa

class EdgesVC: NSViewController {
    @IBOutlet var firstNodeTextField: NSTextField!
    @IBOutlet var secondNodeTextField: NSTextField!
    @IBOutlet var edgeLength: NSTextField!
    @IBOutlet var edgeWeight: NSTextField!
    
    @IBOutlet var tableView: NSTableView!
    
    var fileProcessor: FileProcessor!
    var nodes: [Node] = []
    
    @IBAction func tapAddEdgeButton(_ sender: NSButton) {
        reloadNodes()
        connectNodes()
        fileProcessor.setNodes(array: nodes)
        tableView.reloadData()        
    }
    
    @IBAction func tapDeleteLastEdgeButton(_ sender: NSButton) {
        //        if var storedNodes = fileProcessor.getNodes() {
        //            storedNodes.removeLast() //remove last edited node's edge
        //            fileProcessor.setNodes(array: storedNodes)
        //            reloadEdges()
        //        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Создание Рёбер Графа"
        reloadNodes()
    }
    
    func connectNodes() {
        let firstNodeName = firstNodeTextField.stringValue
        let secondNodeName = secondNodeTextField.stringValue
        let length = edgeLength.intValue
        let weight = edgeWeight.intValue
        guard firstNodeName != "", secondNodeName != "", length != 0 else {
            print("Error! No needed data to create node connection")
            return
        }
        let firstNode = nodes.filter{ $0.name == firstNodeName }.first
        let secondNode = nodes.filter{ $0.name == secondNodeName }.first
        guard let first = firstNode, let second = secondNode else {
            print("Error! There's no such nodes")
            return
        }
        first.connectTo(node: second, edgeLength: Int(length), edgeWeight: Int(weight))
    }
    
    func reloadNodes() {
        if let storedNodes = fileProcessor.getNodes() {
            nodes = storedNodes
            tableView.reloadData()
        }
    }
    
}

extension EdgesVC: NSTableViewDataSource {
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

extension EdgesVC: NSTableViewDelegate {
    
}
