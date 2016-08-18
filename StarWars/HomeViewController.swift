//
//  ViewController.swift
//  StarWars
//
//  Created by John Papa on 8/17/16.
//  Copyright © 2016 John Papa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet var tableView: UITableView!
  @IBOutlet var prevButton: UIButton!
  @IBOutlet var nextButton: UIButton!
  
  var characters: [Character] = []
  var page: Int = 1
  var nextPageUrl: String? = nil
  var prevPageUrl: String? = nil
  let swapiUrl = "http://swapi.co/api/people"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.prevButton.enabled = false
    self.nextButton.enabled = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func prevButtonPressed(sender: UIButton) {
    if prevPageUrl != nil {
      getData(prevPageUrl!)
    }
  }

  @IBAction func nextButtonPressed(sender: UIButton) {
    if nextPageUrl != nil {
      getData(nextPageUrl!)
    }
  }

  @IBAction func refreshButtonPressed(sender: UIButton) {
    getData(swapiUrl)
  }

  func getData(url: String) {
    let url = NSURL(string: url)!
    let session = NSURLSession.sharedSession()
    
    let task = session.dataTaskWithURL(url) { (data, response, error) in
      if let response = response {
        print("Data encoding: \(response.textEncodingName)")
      }
      if let error = error {
        NSLog("Got an error!: \(error.localizedDescription)")
        return
      }
      
      if let data = data {
        NSLog("Got \(data.length) bytes.")
        let str = String(data: data, encoding: NSISOLatin1StringEncoding)
        
        print("*** Here are the string contents:")
        print(str)
        print("*** ***")
        
        let httpResponse = response as! NSHTTPURLResponse
        let statusCode = httpResponse.statusCode
        
        if (statusCode == 200) {
          print("Status code = \(statusCode)")
          print("Everyone is fine, json downloaded successfully.")
          
          let possibleJson = self.parseJson(data)
          if let json = possibleJson {
            self.characters = []
            print(json["results"])

            guard let people = json["results"] as? NSArray else { return }
            
            for person in people {
              guard let personDict = person as? NSDictionary else { continue }
              guard let name = personDict["name"] as? String else { continue }
              guard let homeworld = personDict["homeworld"] as? String else { continue }
              self.characters.append(Character(name: name, homeworld: homeworld))
            }
            
            dispatch_async(dispatch_get_main_queue()) {
              self.tableView.reloadData()
              
              if let next = json["next"] as? String {
                self.nextPageUrl = next
              } else {
                self.nextPageUrl = nil
              }
              self.nextButton.enabled = self.nextPageUrl != nil
              
              if let prev = json["previous"] as? String {
                self.prevPageUrl = prev
              } else {
                self.prevPageUrl = nil
              }
              self.prevButton.enabled = self.prevPageUrl != nil
            }
            
          }
        }
      }
    }
    task.resume()
  }
  
  func parseJson(data: NSData) -> [String: AnyObject]? {
    let options = NSJSONReadingOptions()
    do {
      let json = try NSJSONSerialization.JSONObjectWithData(data, options: options) as? [String: AnyObject]
      if let json = json {
        print("*** Here is the JSON")
        print(json)
        print("*** ***")
      }
      return json
    }
    catch (let parsingError) {
      print(parsingError)
    }
    return nil
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // grouped vertical sections of the tableview
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    // total row count goes here
    return characters.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // at init/appear ... this runs for each visible cell that needs to render
    let cell = tableView.dequeueReusableCellWithIdentifier("charactercell", forIndexPath: indexPath) as! CharacterTableViewCell
    let i: Int = indexPath.row
    
    cell.characterName?.text = "\(characters[i].name)"
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let detail = self.storyboard!.instantiateViewControllerWithIdentifier("characterViewController") as! CharacterViewController
    
    self.navigationController?.pushViewController(detail, animated: true)
    
    detail.getData = { [ weak self ] in
      return self!.characters[ indexPath.row ]
    }
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Star Wars API"
  }
}
