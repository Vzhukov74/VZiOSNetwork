//
//  VZResponse.swift
//  VZiOSNetwork

import Foundation

public struct VZResponse {
    public let code: Int
    public var eTag: String?
    public var data: Data?
    
    init(code: Int, eTag: String? = nil, data: Data? = nil) {
        self.code = code
        self.eTag = eTag
        self.data = data
    }
    
    public func decode<T: Codable>() -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    mutating func add(eTag: String) {
        self.eTag = eTag
    }
}
