//
//  AcronymsAPIModel.swift
//  AcronymsFinder
//
//  Created by u533623 on 13/12/22.
//

import Foundation

struct AcronymResponseModel:Codable{
   
    struct Acronym:Codable {
        var sf: String?
        var lfs: [LF]?
    }

    struct LF:Codable {
        var lf: String?
        var freq, since: Int?
        var vars: [LF]?
        
//        enum CodingKeys:String, CodingKey{
//            case lf = "lf"
//            case frequency = "freq"
//            case since = "since"
//            case variation = "vars"
//        }
    }
}

