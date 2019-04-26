import Foundation

public typealias HTTPHeaders = [String: String]
public typealias HTTPParemeters = [String: Any]

public struct VZURLData {
    let url: String
    let method: String
    var headers: HTTPHeaders?
    var parameters: HTTPParemeters?
    var media: [VZData]?
    var eTag: String? = nil
    
    public init(url: String, method: String = "GET", headers: HTTPHeaders? = nil, parameters: HTTPParemeters? = nil) {
        self.url = url
        self.method = method
        self.headers = headers
        self.parameters = parameters
    }
    
    public mutating func add(parameters: HTTPParemeters) {
        self.parameters = parameters
    }
    
    public mutating func add(headers: HTTPHeaders) {
        self.headers = headers
    }
    
    public mutating func add(media: VZData) {
        self.media = [media]
    }
    
    public mutating func add(media: [VZData]) {
        self.media = media
    }
    
    public mutating func add(eTag: String) {
        self.eTag = eTag
    }
}
