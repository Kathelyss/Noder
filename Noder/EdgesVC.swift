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
    @IBOutlet var firstEdgeWeight: NSTextField!
    @IBOutlet var secondEdgeWeight: NSTextField!
    
    @IBOutlet var tableView: NSTableView!
    
    var fileProcessor = FileProcessor(fileName: "edges.plist")
    var edges: [EdgeSaver] = []
    var nodes: [Node] = []
    
    @IBAction func tapAddEdgeButton(_ sender: NSButton) {
        reloadEdges()
        if let edgeDict = createEdgeDictionary() {
            edges.append(edgeDict)
            fileProcessor.setEdges(array: edges)
            tableView.reloadData()
        } else {
            print("Error! No needed data to add edge")
        }
    }
    
    @IBAction func tapDeleteLastEdgeButton(_ sender: NSButton) {
        if var storedEdges = fileProcessor.getEdges() {
            storedEdges.removeLast() //remove last edited node's edge
            fileProcessor.setEdges(array: storedEdges)
            reloadEdges()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Создание Рёбер Графа"
        reloadEdges()
    }
    
    func createEdgeDictionary() -> EdgeSaver? {
        let firstNodeName = firstNodeTextField.stringValue
        let secondNodeName = secondNodeTextField.stringValue
        let length = edgeLength.intValue
        let firstWeight = firstEdgeWeight.intValue
        let secondWeight = secondEdgeWeight.intValue
        guard firstNodeName != "",secondNodeName != "", length != 0, firstWeight != 0, secondWeight != 0 else {
            print("Error! No needed data to create edge")
            return nil
        }
        
        return EdgeSaver(firstNodeName: firstNodeName,
                         secondNodeName: secondNodeName,
                         length: Int(length),
                         firstWeight: Int(firstWeight),
                         secondWeight: Int(secondWeight))
    }
    
    func reloadEdges() {
        if let storedEdges = fileProcessor.getEdges() {
            edges = storedEdges
            tableView.reloadData()
        }
    }
    
}

extension EdgesVC: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return edges.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let item = (edges)[row]
        let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView
        cell?.textField?.stringValue = item.description
        return cell
    }
}

extension EdgesVC: NSTableViewDelegate {
    
}
