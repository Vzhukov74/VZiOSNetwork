import Foundation

public typealias VZResult = (_ result: VZRequestResult) -> Void

public protocol VZRequestUIProgressDelegate: class {
    func updateUIProgress(_ isRequestInProgress: Bool)
}

public class VZRequest {
    private(set) weak var uiProgressDelegate: VZRequestUIProgressDelegate?
    private(set) var result: VZResult?
    
    let requestData: VZURLData
    
    public init(uiProgressDelegate: VZRequestUIProgressDelegate? = nil, result: VZResult? = nil, requestData: VZURLData) {
        self.uiProgressDelegate = uiProgressDelegate
        self.result = result
        self.requestData = requestData
    }
}
