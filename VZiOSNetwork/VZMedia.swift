import UIKit

public struct VZMedia {
    public let key: String
    public let filename: String
    public let data: Data
    public let mimeType: String
    
    public var isJSON: Bool { return self.mimeType == "json" }
    
    public init?(with image: UIImage, for key: String, filename: String = "file.png") {
        guard let data = image.jpegData(compressionQuality: 0.2) else { return nil }
        
        self.key = key
        self.mimeType = "image/png"
        self.filename = filename
        self.data = data
    }
    
    public init?(with json: Data, for key: String, filename: String = "") {
        self.key = key
        self.mimeType = "json"
        self.filename = filename
        self.data = json
    }
}
