//
//  Model.swift
//  TZ_Project
//
//  Created by Felix Falkovsky on 20.07.2020.
//  Copyright © 2020 Felix Falkovsky. All rights reserved.
//

import Foundation

struct DetailData: Decodable {
    var name: String?
    var data: String?
    var url: String?
    var selectedId: Int?
    var variants: String?
    
    init(dictionary: Dictionary<String, Any>) {
        self.name = dictionary["name"] as? String ?? ""
        self.data = (dictionary["data"] as? Dictionary<String, Any> ?? ["" : ""])["text"] as? String ?? ""
        self.url = (dictionary["data"] as? Dictionary<String, Any> ?? ["" : ""])["url"] as? String ?? ""
        self.selectedId = (dictionary["data"] as? Dictionary<String, Any> ?? ["" : ""])["selectedId"] as? Int ?? 0
        self.variants = (dictionary["data"] as? Dictionary<String, Any> ?? ["" : ""])["variants"] as? String ?? ""
    }
}

var dataTZ: [DetailData] = []

var linkData: URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/sample.json"
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
}

//MARK: JSONDecoder

func loadData(completionHeandler: (() -> Void)?) {
    let url = URL(string: "https://pryaniky.com/static/json/sample.json")
    let session = URLSession(configuration: .default)
    
    let downloadTask = session.downloadTask(with: url!) { (urlFile, response, error) in
        if urlFile != nil {
            
            try? FileManager.default.copyItem(at: urlFile!, to: linkData)
            parseData()
            completionHeandler?()
        }
    }
    downloadTask.resume()
}

func parseData() {
    
    let data = try? Data(contentsOf: linkData)
    
    // проверка на nil
    if data == nil {
        return
    }
    
    let rootDictionaryArray = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
    if rootDictionaryArray == nil {
        return
    }
    
    let rootDictionary = rootDictionaryArray as? Dictionary<String, Any>
    if rootDictionary == nil {
        return
    }
    
    if let arrayData = rootDictionary!["data"] as? [Dictionary<String, Any>] {
        
        var returnArray: [DetailData] = []
        
        for dict in arrayData {
            let newData = DetailData(dictionary: dict)
            returnArray.append(newData)
        }
        dataTZ = returnArray
    }
}
