//
//  ReachabilityManager.swift
//
// Created by CrestAdmin on 25/07/24.
//

import Foundation

class ReachabilityManager
{
    static let sharedInstance = ReachabilityManager()
    let rechabilityObj : Reachability!
    
    init()
    {
        rechabilityObj = Reachability.init(hostname: "https://www.google.com/")
        do{
            try rechabilityObj.startNotifier()
        }
        catch{
            //print("Reachability throws exception!")
        }
        
    }
    
    func isReachable() -> Bool
    {
        return Reachability.init()?.currentReachabilityStatus != Reachability.NetworkStatus.notReachable
        //return rechabilityObj.currentReachabilityStatus != Reachability.NetworkStatus.notReachable
    }
    
    func isUnreachable() -> Bool
    {
        return Reachability.init()?.currentReachabilityStatus == Reachability.NetworkStatus.notReachable
    }
    
    func isReachableViaWWAN() -> Bool
    {
        return Reachability.init()?.currentReachabilityStatus == Reachability.NetworkStatus.reachableViaWWAN
    }
    
    func isReachableViaWiFi() -> Bool
    {
        return Reachability.init()?.currentReachabilityStatus == Reachability.NetworkStatus.reachableViaWiFi
       // return ReachabilityManager.sharedInstance.rechabilityObj.currentReachabilityStatus == Reachability.NetworkStatus.reachableViaWiFi
    }
    
    deinit
    {
        rechabilityObj.stopNotifier()
    }
}
