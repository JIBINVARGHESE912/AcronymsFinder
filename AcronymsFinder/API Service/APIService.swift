//
//  APIService.swift
//  AcronymsFinder
//
//

import Foundation

enum APIResponseHandler {
    case statusCode(Int)
    case failure(Error)
    case errorMessage(String)
}

protocol AcronymSearchAPIProtocol {
    func getAcronymSearchDetails(searchText:String, completionSuccess : @escaping([Acronym]) -> Void, CompletionFail: @escaping(APIResponseHandler) -> Void)
}

class AcronymSearchAPI:AcronymSearchAPIProtocol{
    
    //To get acronym search details
    func getAcronymSearchDetails(searchText:String, completionSuccess : @escaping([Acronym]) -> Void, CompletionFail: @escaping(APIResponseHandler) -> Void) {
                let request = getRequest(urlString:APIConstants.url + searchText)
        let session = URLSession.shared
        let dataRask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            guard let response = response as? HTTPURLResponse else { return }
            if error == nil && response.statusCode == StatusCode.Success {
                if let data = data {
                    do {
                        let acronymsDetails = try JSONDecoder.init().decode([Acronym].self, from: data)
                        completionSuccess(acronymsDetails)
                    } catch {
                        debugPrint(error.localizedDescription)
                        CompletionFail(APIResponseHandler.failure(error))
                    }
                }
            }
            else if response.statusCode == StatusCode.Unauthorised {
                CompletionFail(APIResponseHandler.statusCode(response.statusCode))
            }
            else if response.statusCode == StatusCode.ServerException {
                CompletionFail(APIResponseHandler.statusCode(response.statusCode))
            }
            else{
                if let error = error {
                    CompletionFail(APIResponseHandler.failure(error))
                }
            }
        }
        dataRask.resume()
    }
    
    //To create URLRequest
    func getRequest(urlString:String)->URLRequest {
        
        let url = URL(string:urlString)
        var request = URLRequest(url: url!)
        request.addValue(HeaderConstants.kJson, forHTTPHeaderField: HeaderConstants.kContent)
        request.httpMethod = HeaderConstants.kGetMethod
        return request
    }
}
