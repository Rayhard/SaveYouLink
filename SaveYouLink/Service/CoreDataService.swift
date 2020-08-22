//
//  CoreDataService.swift
//  SaveYouLink
//
//  Created by Никита Пережогин on 22.08.2020.
//  Copyright © 2020 Nikita Perezhogin. All rights reserved.
//

import UIKit
import CoreData

class CoreDataService {
    private init(){}
    
    static let shared = CoreDataService()
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveData(withContext context: NSManagedObjectContext) {
        do {
            try context.save()

        } catch let error as NSError{
            print(error.localizedDescription)
        }
        
    }
    
    func fetchData(withRequest fetchRequest: NSPersistentStoreRequest) -> [Any]{
        
        let context = getContext()
        
        do {
            return try context.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
            
        } catch let error as NSError{
            print(error.localizedDescription)
            return []
        }
    }
}


//    private func getDataFromFile() {
//        guard let pathToFile = Bundle.main.path(forResource: "data", ofType: "plist"),
//            let dataArray = NSArray(contentsOfFile: pathToFile) else { return }
//
//        let context = getContext()
//
//        for dictionary in dataArray {
//            let entity = NSEntityDescription.entity(forEntityName: "LinkItem", in: context)
//            let link = NSManagedObject(entity: entity!, insertInto: context) as! LinkItem
//
//            let linkDictionary = dictionary as! [String: AnyObject]
//            link.urlLink = linkDictionary["urlLink"] as? String
//            link.title = linkDictionary["title"] as? String
//        }
//    }


        // Полное удаление
//        let context = getContext()
//        let fetchRequest: NSFetchRequest<LinkItem> = LinkItem.fetchRequest()
//        if let results = try? context.fetch(fetchRequest){
//            for object in results {
//                context.delete(object)
//            }
//        }
//
//        do {
//            try context.save()
//
//        } catch let error as NSError{
//            print(error.localizedDescription)
//        }
