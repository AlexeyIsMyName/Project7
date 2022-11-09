//
//  ViewController.swift
//  Project7
//
//  Created by ALEKSEY SUSLOV on 09.11.2022.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        DispatchQueue.global().async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    // we're OK to parse!
                    DispatchQueue.main.async {
                        self.parse(json: data)
                    }
                }
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
//        cell.textLabel?.text = "Title goes here"
//        cell.detailTextLabel?.text = "Subtitle goes here"
        return cell
    }
}
