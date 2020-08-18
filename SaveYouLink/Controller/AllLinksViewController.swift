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
    }
    
    var linkItems: [LinkItem] = []
    
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
        
        let index = linkItems[indexPath.row]
        
        cell.title.text = index.title
        cell.urlLink.text = index.link
        
        return cell
    }
    
}
