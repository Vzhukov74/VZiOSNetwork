//
//  VZNetworkTaskDebug.swift
//  VZiOSNetwork

import Foundation

public class VZNetworkTaskDebug {
    public static var isDebugActive: Bool = false
    
    class func debugPrint(_ data: Data?) {
        if VZNetworkTaskDebug.isDebugActive {
            guard let data = data else { return }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
            print(json)
        }
    }
}
