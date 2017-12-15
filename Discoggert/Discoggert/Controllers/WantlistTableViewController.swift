//
//  WantlistTableViewController.swift
//  Discoggert
//
//  Created by Timo den Hartog on 08-12-17.
//  Copyright © 2017 Timo den Hartog. All rights reserved.
//

import UIKit

class ListTableCell: UITableViewCell {
    
    var searchResult: Result!
    
    var titleLabel: String = ""
    var yearLabel: String = ""
    var genreLabel: String = ""
    
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultYearLabel: UILabel!
    @IBOutlet weak var resultGenreLabel: UILabel!
    
    //    override func awakeFromNib() {
    //                super.awakeFromNib()
    //                // Initialization code
    //            }
    
}

class WantlistTableViewController: UITableViewController {
    
    //let ListToSearch = "ListToSearch"
    
    let customCharacterSet = CharacterSet.init(arrayLiteral: ")","(")

    
    @IBAction func AddButtonTouched(_ sender: Any) {
        performSegue(withIdentifier: "ListToSearch", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchViewController.counter
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! SearchTableCell
        let searchResult = SearchViewController.resultArrayForTable[indexPath.row]
        
        cell.resultTitleLabel.text = searchResult.title.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print("test")
        print(cell.resultTitleLabel.text!)
        cell.resultYearLabel.text = searchResult.year.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        print("test")
        print(cell.resultYearLabel.text!)
        cell.resultGenreLabel.text = searchResult.genre.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).trimmingCharacters(in: customCharacterSet)
        print("test")
        print(cell.resultGenreLabel.text!)
        
        return cell
    }
    
    
    
}
