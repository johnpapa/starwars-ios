//
//  CharacterTableViewCell.swift
//  StarWars
//
//  Created by John Papa on 8/17/16.
//  Copyright © 2016 John Papa. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
  
  @IBOutlet var characterImageView: UIImageView!
  @IBOutlet var characterName: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
}
