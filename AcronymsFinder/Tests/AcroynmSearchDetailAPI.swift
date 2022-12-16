//
//  AcroynmSearchDetailAPI.swift
//  AcronymsFinder
//
//  Created by u533623 on 14/12/22.
//

import Foundation

//struct Acronym:Codable {
//    var sf: String?
//    var lfs: [LF]?
//
//    enum CodingKeys:String, CodingKey{
//        case sf = "sf"
//        case lfs = "lfs"
//    }
//}
//
//struct LF:Codable {
//    var lf: String?
//    var frequency, since: Int?
//    var variation: [LF]?
//
//    enum CodingKeys:String, CodingKey{
//        case lf = "lf"
//        case frequency = "freq"
//        case since = "since"
//        case variation = "vars"
//    }
//}

//enum APIResponseHandler {
//    case parsing(Error)
//}

class AcronymSearchDetailAPI{
    
    let urlSession:URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
//    func fetchAcronymSearchDetail(completion: @escaping (_ result: Result<[Acronym], Error>) -> Void) {
//       let url = URL(string: "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=nasa")!
//       let dataTask = urlSession.dataTask(with:url) { (data, urlResponse, error) in
//         do{
//
//             if let error = error {
//             throw error
//           }
//
//             guard let httpResponse = urlResponse as? HTTPURLResponse, 200 == httpResponse.statusCode else {
//                 completion(Result.failure(error!))
//             return
//           }
//
//           if let responseData = data, let acronymDetails = try? JSONDecoder().decode([Acronym].self, from: responseData) {
//             completion(Result.success(acronymDetails))
//           } else {
//               completion(Result.failure(error!))
//           }
//         }catch{
//           completion(Result.failure(error))
//         }
//       }
//
//       dataTask.resume()
//     }
}
