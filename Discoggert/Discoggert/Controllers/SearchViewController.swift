//
//  SearchViewController.swift
//  Discoggert
//
//  Created by Timo den Hartog on 12-12-17.
//  Copyright © 2017 Timo den Hartog. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SearchViewController: UIViewController {
    
    //var ref: DatabaseReference!
    var ref = Database.database().reference(withPath: "Wantlist-Items")
    
    @IBOutlet weak var searchFunctionOutlet: UITextField!
    
    @IBAction func searchButtonTouched(_ sender: Any) {
        self.generateResult(withQuery: searchFunctionOutlet.text!) { (results: [Result]) in
        }
        sleep(1)
        performSegue(withIdentifier: "SearchToSearchResults", sender: nil)
    }
    
    
    // converted to static var so it can be used in SearchTable
    static var resultArrayForTable: [Result] = []
    
    static var counter = 0
    
    static let basePath = "https://api.discogs.com/database/search?q="
    

    // made regular func from static func
    func generateResult (withQuery query: String, completion: @escaping ([Result]) -> () ) {
        
        let url = SearchViewController.basePath + query + "&type=release&key=EFGTtfZnuybCfPZTmVQZ&secret=ZKfBxMijwvefNopzyQIPShSJqwomBOpi"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            //            var resultArray: [Result] = []
            //var resultArray: [Any] = []
            var titleArray: [String] = []
            var yearArray: [String] = []
            var genreArray: [String] = []
            var IDArray: [String] = []
            
            var resultID = ""
            var resultTitle = ""
            var resultYear = ""
            var resultGenre = ""
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        
                        //print(json)
                        if let results = json["results"] as? NSArray {
                            
                            print("testing")
                            var itemCounter = 1
                            
                            // result is a release (or artist profile)
                            for result in results {
                                
                                // converts to string
                                let stringedResult = String(describing: result)
                                
                                // creates array of stats per result
                                let stringedResultArr = stringedResult.split{$0 == ";"}.map(String.init)
                                
                                // print(stringedResultArr)
                                
                                // each item represents a different stat within the statistics array
                                for item in stringedResultArr {
                                    if item.contains("id =") {
                                        print(item)
                                        IDArray.append(item)
                                        
                                        // appending ID's per release to Firebase
                                        let ID = item
                                        let IDname = "ID" +  String(describing: itemCounter)
                                        let IDRef = self.ref.child(IDname)
                                    
                                        IDRef.setValue(ID)
                                        resultID = item
                                    }
                                    if item.contains("title") {
                                        print(item)
                                        titleArray.append(item)
                                        resultTitle = item
                                    }
                                    else if item.contains("year") {
                                        print(item)
                                        yearArray.append(item)
                                        resultYear = item
                                    }
                                    else if item.contains("genre") {
                                        print(item)
                                        genreArray.append(item)
                                        resultGenre = item
                                    }
                                }
                                itemCounter += 1
                                let result = Result(ID: resultID, title: resultTitle, year: resultYear, genre: resultGenre)
                                //resultArray.append(result)
                                SearchViewController.resultArrayForTable.append(result)
                            }
                            SearchViewController.counter = itemCounter
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
        
        // Final '}' of result func for reference
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchToSearchResults" {
            
        }
    }
    
    @IBAction func unwindToSearchViewController(segue: UIStoryboardSegue) {
        if segue.identifier == "SearchResultsToSearch" {
            
        }
    }
    
}
