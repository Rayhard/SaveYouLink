//
//  ViewController.swift
//  SaveYouLink
//
//  Created by Никита Пережогин on 18.08.2020.
//  Copyright © 2020 Nikita Perezhogin. All rights reserved.
//

import UIKit

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
                                            guard let link = LinkCoreDataService.saveLinkToData(link: newLink) else { return }
                                            self.linkItems.append(link)
                                            self.tableView.reloadData()
                                        }
        }
        
        alertController.addTextField(configurationHandler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    var linkItems: [LinkItem] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        linkItems = LinkCoreDataService.getLinkFromData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let link = linkItems[indexPath.row]
        cell.configure(link: link)
        
        return cell
    }
    
}
