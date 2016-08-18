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
      self.homeworldLabel.text = character!.homeworld
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
