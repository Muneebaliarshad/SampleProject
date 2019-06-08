//
//  CoreDataManager.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import Foundation
import CoreData


final class CoreDataManager {
    
    //MARK: - Variables
    static let context = Constants.AppDelegate.persistentContainer.viewContext
    
    
    static func convertToJSONArray(moArray: [NSManagedObject]) -> Any {
        var jsonArray: [[String: Any]] = []
        for item in moArray {
            var dict: [String: Any] = [:]
            for attribute in item.entity.attributesByName {
                //check if value is present, then add key to dictionary so as to avoid the nil value crash
                if let value = item.value(forKey: attribute.key) {
                    dict[attribute.key] = value
                }
            }
            jsonArray.append(dict)
        }
        return jsonArray
    }
    
    
    static func getData() ->  [[String: Any]]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity Name")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(fetchRequest)
            return convertToJSONArray(moArray: result as! [NSManagedObject]) as! [[String : Any]]
        } catch {
            print("Failed")
            return []
        }
    }
    
    
    static func deleteData(data: [String: Any]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity Name")
        
        if let result = try? context.fetch(fetchRequest) {
            for item in result as! [NSManagedObject] {
                for attribute in item.entity.attributesByName {
                    if attribute.key == "ID" {
                        if let value = item.value(forKey: attribute.key) {
                            if (data["ID"] as! String) == (value as? String) {
                                do {
                                    context.delete(item)
                                    try context.save()
                                } catch {
                                    print ("There was an error")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}
