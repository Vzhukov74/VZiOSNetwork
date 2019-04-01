import Foundation
import UIKit

public class VZNetwork {
    public static func perform(with request: VZRequest, for session: URLSession = URLSession.shared) {
        DispatchQueue.main.async {
            request.uiProgressDelegate?.updateUIProgress(false)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
        guard let urlRequest = VZNetworkRequestBuilder.build(for: request.requestData) else {
            DispatchQueue.main.async {
                request.result?(.fail("error with build request"))
            }
            return
        }
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            VZNetworkTaskDebug.debugPrint(data)
            
            DispatchQueue.main.async {
                request.uiProgressDelegate?.updateUIProgress(false)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            let httpResponse = response as? HTTPURLResponse
            let statusCode = httpResponse?.statusCode ?? 999
            
            guard error == nil else {
                let errorMessage = "\(error?.localizedDescription ?? "")"
                DispatchQueue.main.async {
                    request.result?(.fail(errorMessage))
                }
                return
            }
            
            guard let data = data else {
                let errorMessage = "data is nil"
                DispatchQueue.main.async {
                    request.result?(.fail(errorMessage))
                }
                return
            }
            
            var result = VZResponse(code: statusCode, data: data)
            
            if statusCode == 200 {
                if let eTagStr = (response as? HTTPURLResponse)?.allHeaderFields["Etag"] as? String {
                    result.add(eTag: eTagStr)
                }
            }
            
            DispatchQueue.main.async {
                request.result?(.success(result))
            }
        })
        
        DispatchQueue.main.async {
            request.uiProgressDelegate?.updateUIProgress(true)
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        task.resume()
    }
}
