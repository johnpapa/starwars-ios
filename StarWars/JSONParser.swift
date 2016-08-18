//
//  JSONParser.swift
//  StarWars
//
//  Created by John Papa on 8/18/16.
//  Copyright © 2016 John Papa. All rights reserved.
//

import Foundation

class JSONParser {
  static func parseJson(data: NSData) -> [String: AnyObject]? {
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
}

