#if os(iOS)
import UIKit

extension UIImage {

    /// Downscales the image to fit within `maxDimension` and returns an
    /// upright CGImage, keeping model request payloads reasonably sized.
    public func downscaled(maxDimension: CGFloat) -> CGImage? {
        let largest = max(size.width, size.height)
        guard largest > maxDimension else { return cgImage }
        let scale = maxDimension / largest
        let target = CGSize(width: size.width * scale, height: size.height * scale)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        return UIGraphicsImageRenderer(size: target, format: format).image { _ in
            draw(in: CGRect(origin: .zero, size: target))
        }.cgImage
    }
}
#endif
