//
//  Character.swift
//  StarWars
//
//  Created by John Papa on 8/17/16.
//  Copyright © 2016 John Papa. All rights reserved.
//

import Foundation

class Character {
  var name: String
  var homeworld: String
  
  init(name: String, homeworld: String) {
    self.name = name
    self.homeworld = homeworld
  }
}