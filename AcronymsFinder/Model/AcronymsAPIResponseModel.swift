//
//  AcronymsAPIResponseModel.swift
//  AcronymsFinder
//

import Foundation
   
struct Acronym:Codable {
    var sf: String?
    var lfs: [LF]?
    enum CodingKeys:String, CodingKey{
        case sf = "sf"
        case lfs = "lfs"
    }
}

struct LF:Codable {
    var lf: String?
    var frequency, since: Int?
    var variation: [LF]?
    enum CodingKeys:String, CodingKey{
        case lf = "lf"
        case frequency = "freq"
        case since = "since"
        case variation = "vars"
    }
}
