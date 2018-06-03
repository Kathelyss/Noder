//
//  FileProcessor.swift
//  Noder
//
//  Created by Екатерина Рыжова on 27.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

struct EdgeSaver: Codable, CustomStringConvertible {
    var firstNodeName: String
    var secondNodeName: String
    var length: Int
    var firstWeight: Int
    var secondWeight: Int
    var description: String {
        return "\(firstNodeName) -> \(secondNodeName), длина \(length), вес -> \(firstWeight), <- \(secondWeight)"
    }
}

class FileProcessor {
    var fileName: String
    var url: URL? { return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first }
    var path: URL?  { return url?.appendingPathComponent(fileName) }
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func setNodes(array: [Node]) {
        guard let url = path else { return }
        
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        do {
            let data = try encoder.encode(array)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
    
    func getNodes() -> [Node]? {
        guard let url = path else { return nil }
        
        if let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()
            let array: [Node]? = try? decoder.decode([Node].self, from: data)
            return array
        }
        return nil
    }
    
    func setEdges(array: [EdgeSaver]) {
        guard let url = path else { return }
        
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        do {
            let data = try encoder.encode(array)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
    
    func getEdges() -> [EdgeSaver]? {
        guard let url = path else { return nil }
        
        if let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()
            let array: [EdgeSaver]? = try? decoder.decode([EdgeSaver].self, from: data)
            return array
        }
        return nil
    }
}
