import UIKit

public struct VZMedia {
    public let key: String
    public let filename: String
    public let data: Data
    public let mimeType: String
    
    public init?(with image: UIImage, for key: String, filename: String = "file.png") {
        guard let data = image.jpegData(compressionQuality: 0.2) else { return nil }
        
        self.key = key
        self.mimeType = "image/png"
        self.filename = filename
        self.data = data
    }
}
