//
//  SearchTableViewController.swift
//  Discoggert
//
//  Created by Timo den Hartog on 14-12-17.
//  Copyright © 2017 Timo den Hartog. All rights reserved.
//

import UIKit
import Firebase

class SearchTableCell: UITableViewCell {
    
    var searchResult: Result!
    
    var titleLabel: String = ""
    var yearLabel: String = ""
    var genreLabel: String = ""
    
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultYearLabel: UILabel!
    @IBOutlet weak var resultGenreLabel: UILabel!
}

class SearchResultsTableViewController: UITableViewController {
    
    let customCharacterSet = CharacterSet.init(arrayLiteral: ")","(")
    
    var ref2 = Database.database().reference(withPath: "Wantlist-Items")
    
    var ListTitleLabel = ""
    var ListYearLabel = ""
    var ListGenreLabel = ""

    override func viewDidLoad() {
        super.viewDidLoad()        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchViewController.counter
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 180
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! SearchTableCell
        let searchResult = SearchViewController.resultArrayForTable[indexPath.row]
        
        cell.resultTitleLabel.text = searchResult.title.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        ListTitleLabel = searchResult.title.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print("test")
        print(cell.resultTitleLabel.text!)
        
        cell.resultYearLabel.text = searchResult.year.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        ListYearLabel = searchResult.year.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print("test")
        print(cell.resultYearLabel.text!)
        
        cell.resultGenreLabel.text = searchResult.genre.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).trimmingCharacters(in: customCharacterSet)
        ListYearLabel = searchResult.genre.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print("test")
        print(cell.resultGenreLabel.text!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
