//
//  Utilities.swift
//  AcronymsFinder
//
//

import Foundation
import UIKit

class Utilities:NSObject{
    
    static func showAlertMessage(statusCode: Int){
        
        let statusMessage = getAlertMessage(statusCode: statusCode)
        showAlert(message: statusMessage)
    }
    
    //To get alert message from status code
    static func getAlertMessage(statusCode:Int)->String{
        
        var statusMessage:String = ""
        switch statusCode{
        case 400:
            statusMessage = "Bad request"
            break
        case 401:
            statusMessage = "Unauthorised Access"
            break
        case 403:
            statusMessage = "Forbidden"
            break
        case 404:
            statusMessage = "Not found"
            break
        case 500:
            statusMessage = "Server Exception"
            break
            
        default:
            statusMessage = "Unknown Exception"
            
        }
        return statusMessage
    }
    
    //To show alert with message
    static func showAlert(message:String){
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: ConfigurationConstants.appTitle, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                switch action.style{
                    
                case .default:
                    break
                    
                case .cancel:
                    break
                    
                case .destructive:
                    break
                @unknown default:
                    break
                }}))
            UIApplication.shared.windows.last?.rootViewController?.present(alert, animated: true)
            
        }
    }
    
    static func showError(error: Error){
        
        self.showAlert(message: error.localizedDescription)
    }
}
