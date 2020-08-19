//
//  ViewController.swift
//  SaveYouLink
//
//  Created by Никита Пережогин on 18.08.2020.
//  Copyright © 2020 Nikita Perezhogin. All rights reserved.
//

import UIKit
import CoreData

class AllLinksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func addButton(_ sender: Any) {
        let alertController = UIAlertController(title: "New Link",
                                                message: "Add new link",
                                                preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        let tf = alertController.textFields?.first
                                        if let newLink = tf?.text {
                                            self.saveData(withLink: newLink)
                                            self.tableView.reloadData()
                                        }
        }
        
        alertController.addTextField(configurationHandler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func saveData(withLink link: String){
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "LinkItem", in: context) else { return }
        
        let linkObject = LinkItem(entity: entity, insertInto: context)
//        linkObject.title = "test"
        linkObject.urlLink = link
        
        do {
            try context.save()
            linkItems.append(linkObject)
            
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    var linkItems: [LinkItem] = []
    
    // Получаем контекст
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // получаем данные из core data
        let context = getContext()
        let fetchRequest: NSFetchRequest<LinkItem> = LinkItem.fetchRequest()
        
        do {
            linkItems = try context.fetch(fetchRequest)
            
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LinkCell", bundle: nil), forCellReuseIdentifier: "LinkCell")
    }

}

extension AllLinksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return linkItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LinkCell", for: indexPath) as! LinkCell
        
        let index = linkItems[indexPath.row]
        
        cell.urlLink.text = index.urlLink
        
        return cell
    }
    
}
