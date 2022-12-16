//
//  ConnectionManager.swift
//  AcronymsFinder
//
//

import Foundation
import UIKit

protocol ConnectionDelegate:AnyObject{
    func retryNetworkCall()
    func netWorkAvailbe(status:Bool)
}

class ConnectionManager {
    
    weak var delegate: ConnectionDelegate?
    static let sharedInstance = ConnectionManager()
    var retry = false
    private var reachability : Reachability!
    private init(){
        self.reachability = Reachability()
    }
    @discardableResult
    func checkNetworkAvailability(alert:Bool = true )->Bool{
        let status = self.reachability.connection
        observeReachability()
        if status == .none {
            if alert == true {
                showOKAlert()
            }
            return false
        }
        return true
    }
    
    func observeReachability(){
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            try self.reachability.startNotifier()
        }
        catch(let error) {
            debugPrint("Error occured while starting reachability notifications : \(error.localizedDescription)")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .cellular:
            self.delegate?.netWorkAvailbe(status: true)
            if retry == true{
                showRetryAlert()
            }
            break
        case .wifi:
            debugPrint("Network available via WiFi.")
            self.delegate?.netWorkAvailbe(status: true)
            if retry == true{
                showRetryAlert()
            }
            break
        case .none:
            debugPrint("Network is not available.")
            self.delegate?.netWorkAvailbe(status: false)
            break
        }
    }
    
    private func showOKAlert(){
        let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message:NSLocalizedString(ConfigurationConstants.kNetworkNotAvailable, comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: nil))
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        window!.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    private func showRetryAlert(){
        
        self.delegate?.retryNetworkCall()
        
    }
}
