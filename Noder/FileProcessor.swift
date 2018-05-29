//
//  FileProcessor.swift
//  Noder
//
//  Created by Екатерина Рыжова on 27.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

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
//            print(array)
            return array
        }
        return nil
    }
}
