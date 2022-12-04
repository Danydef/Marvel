//
//  MarvelApiConstants.swift
//  RickAndMorty
//
//  Created by Daniel Personal on 29/11/22.
//

import Foundation

class MarvelApiConstants {
    private static var infoPlist: String {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Info.plist'.")
        }
        return filePath
    }
    
    static var serverURL: String {
        let plist = NSDictionary(contentsOfFile: infoPlist)
        guard let value = plist?.object(forKey: "SERVER_URL") as? String else {
          fatalError("Couldn't find key 'SERVER_URL' in 'Info.plist'.")
        }
        if value.starts(with: "_") {
          fatalError("Register for a Marvel developer account and get an API key at https://developer.marvel.com/account and added info to MARVEL_HASH and MARVEL_API_KEY in Build Settings -> User_defined.")
        }
        return value
    }
    
    static var apiKey: String {
        let plist = NSDictionary(contentsOfFile: infoPlist)
        guard let value = plist?.object(forKey: "MARVEL_API_KEY") as? String else {
          fatalError("Couldn't find key 'MARVEL_API_KEY' in 'Info.plist'.")
        }
        if value.starts(with: "_") {
          fatalError("Register for a Marvel developer account and get an API key at https://developer.marvel.com/account and added info to MARVEL_HASH and MARVEL_API_KEY in Build Settings -> User_defined.")
        }
        return value
    }
    
    static var hash: String {
        let plist = NSDictionary(contentsOfFile: infoPlist)
        guard let value = plist?.object(forKey: "MARVEL_HASH") as? String else {
          fatalError("Couldn't find key 'MARVEL_HASH' in 'Info.plist'.")
        }
        if value.starts(with: "_") {
          fatalError("Register for a Marvel developer account and get an API key at https://developer.marvel.com/account and added info to MARVEL_HASH and MARVEL_API_KEY in Build Settings -> User_defined.")
        }
        return value
    }
    
    static var timeStamp: String {
        let plist = NSDictionary(contentsOfFile: infoPlist)
        guard let value = plist?.object(forKey: "MARVEL_TS") as? String else {
          fatalError("Couldn't find key 'MARVEL_TS' in 'Info.plist'.")
        }
        if value.starts(with: "_") {
          fatalError("Register for a Marvel developer account and get an API key at https://developer.marvel.com/account and added info to MARVEL_HASH and MARVEL_API_KEY in Build Settings -> User_defined.")
        }
        return value
    }
    
    static var version: String {
        let plist = NSDictionary(contentsOfFile: infoPlist)
        guard let value = plist?.object(forKey: "SERVER_VERSION") as? String else {
          fatalError("Couldn't find key 'SERVER_VERSION' in 'Info.plist'.")
        }
        if value.starts(with: "_") {
          fatalError("Register for a Marvel developer account and get an API key at https://developer.marvel.com/account and added info to MARVEL_HASH and MARVEL_API_KEY in Build Settings -> User_defined.")
        }
        return value
    }
}
