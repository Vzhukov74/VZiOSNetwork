//
//  VZNetworkRequestBuilder.swift
//  VZiOSNetwork

import Foundation

class VZNetworkRequestBuilder {
    class func build(for urlData: VZURLData) -> URLRequest? {
        if let media = urlData.media {
            return VZURLHelper.createRequestFor(upload: media, to: urlData.url)
        }
        
        var urlStr = urlData.url
        if urlData.method == "GET", urlData.parameters != nil {
            let parametersStr = VZURLHelper.getString(for: urlData.parameters!)
            urlStr = urlData.url + "?" + parametersStr
        }
        
        guard let url = URL(string: urlStr) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = urlData.method
        VZNetworkRequestBuilder.addHeaders(for: &request, headers: urlData.headers)
        
        if urlData.method == "POST", urlData.parameters != nil {
            let httpBody = VZURLHelper.postString(for: urlData.parameters!).data(using: .utf8, allowLossyConversion: true)
            request.httpBody = httpBody
        }
        
        if let etagStr = urlData.eTag, !etagStr.isEmpty {
            request.addValue(etagStr, forHTTPHeaderField: "If-None-Match")
        }
        
        return request
    }
    
    private class func addHeaders(for request: inout URLRequest, headers: HTTPHeaders?) {
        guard let headers = headers else { return }
        
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
    }
}
