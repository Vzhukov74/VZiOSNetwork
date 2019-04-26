import Foundation

public typealias VZResultBlock = (_ result: VZResult) -> Void

public protocol VZRequestUIProgressDelegate: class {
    func updateUIProgress(_ isRequestInProgress: Bool)
}

public class VZRequest {
    private(set) weak var uiProgressDelegate: VZRequestUIProgressDelegate?
    private(set) var result: VZResultBlock?
    
    let requestData: VZURLData
    
    public init(uiProgressDelegate: VZRequestUIProgressDelegate? = nil, result: VZResultBlock? = nil, requestData: VZURLData) {
        self.uiProgressDelegate = uiProgressDelegate
        self.result = result
        self.requestData = requestData
    }
    
    public func buildURLRequest() -> URLRequest? {
        var urlStr = requestData.url
        if requestData.method == "GET" {
            urlStr += VZURLHelper.getString(for: requestData.parameters)
        }
        
        guard let url = URL(string: urlStr) else { return nil }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = requestData.method
        request.add(headers: requestData.headers)
        
        if requestData.method == "POST" {
            request.httpBody = VZURLHelper.postData(for: requestData.parameters)
            
            if let media = requestData.media {
                VZURLHelper.configure(for: &request, with: media)
            }
        }
        
        if let etagStr = requestData.eTag, !etagStr.isEmpty {
            request.addValue(etagStr, forHTTPHeaderField: "If-None-Match")
        }
        
        return request
    }
        
    deinit {
        print("deinit \(requestData.url) request")
    }
}
