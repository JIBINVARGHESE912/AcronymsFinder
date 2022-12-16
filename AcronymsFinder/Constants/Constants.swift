//
//  Constants.swift
//  AcronymsFinder
//
//

import Foundation

struct APIConstants{
    
    static var url:String{
        
        return "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf="
    }
}

struct  HeaderConstants {
    static let kJson = "application/json"
    static let kContent = "Content-Type"
    static let kGetMethod = "GET"
}

struct StatusCode{
    
    static let Success = 200
    static let ServerException = 500
    static let Unauthorised = 401
}

struct TableViewCell{
    
    static let customTableViewCell = NSLocalizedString("customTableViewCell", comment: "")
}

struct ConfigurationConstants {
    static let kAlert = NSLocalizedString("Alert", comment: "")
    static let kNetworkNotAvailable = "Network is Not Available"
    static let kNetworkAvailable = "Network Is Available"
    static let appTitle = NSLocalizedString("AcronymsFinder", comment: "")
}

struct CharactersSet{
    
    static let characterSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"
}
