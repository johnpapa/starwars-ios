//
//  CharacterViewController.swift
//  StarWars
//
//  Created by John Papa on 8/17/16.
//  Copyright © 2016 John Papa. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
  @IBOutlet var tableView: UITableView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var homeworldLabel: UILabel!
  
  var character: Character? = nil
  var getData: (() -> (Character))?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let closure = self.getData {
      character = closure()
      self.nameLabel.text = character!.name
      self.homeworldLabel.text = ""
      getHomeworld()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func getHomeworld() {
    let url = NSURL(string: character!.homeworld)!
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
        let httpResponse = response as! NSHTTPURLResponse
        let statusCode = httpResponse.statusCode
        
        if (statusCode == 200) {
          let possibleJson = JSONParser.parseJson(data)
          if let json = possibleJson {
            guard let homeworld = json["name"] as? String else { return }
            dispatch_async(dispatch_get_main_queue()) {
              self.homeworldLabel.text = homeworld
            }
          }
        }
      }
    }
    task.resume()
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
