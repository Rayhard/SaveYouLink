//
//  LinkCoreDataService.swift
//  SaveYouLink
//
//  Created by Никита Пережогин on 22.08.2020.
//  Copyright © 2020 Nikita Perezhogin. All rights reserved.
//

import Foundation
import CoreData

class LinkCoreDataService {
    private init () {}
    
    static func getLinkFromData() -> [LinkItem] {
        let fetchRequest: NSFetchRequest<LinkItem> = LinkItem.fetchRequest()
        
        guard let dataItems: [LinkItem] = CoreDataService.shared.fetchData(withRequest: fetchRequest) as? [LinkItem] else { return [] }
        
        return dataItems
    }
    
    static func saveLinkToData(link: String) -> LinkItem?{
        let context = CoreDataService.shared.getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "LinkItem", in: context) else { return nil }
        
        let linkObject = LinkItem(entity: entity, insertInto: context)
        //        linkObject.title = "test"
        linkObject.urlLink = link
        
        CoreDataService.shared.saveData(withContext: context)
        
        return linkObject
    }
}
