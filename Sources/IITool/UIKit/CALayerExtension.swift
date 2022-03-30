//
//  CALayerExtension.swift
//  
//
//  Created by ice on 2021/9/7.
//

#if canImport(UIKit)
import UIKit

// MARK: - Methods
public extension CALayer {
    /// IITool: set Sketch/Zeplin shadow
    ///
    /// - Parameters:
    ///   - color: shadow color
    ///   - alpha: shadow alpha/opacity
    ///   - x, y: shadow offset
    ///   - blur: shadow radius/blur
    ///   - spread: shadow inset
    func setSketchShadow(color: UIColor? = .black,
                         alpha: CGFloat = 0.5,
                         x: CGFloat = 0, y: CGFloat = 5,
                         blur: CGFloat = 10,
                         spread: CGFloat = 0) {
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur * 0.5
        shadowColor = color?.cgColor
        shadowOpacity = Float(alpha)

        let rect = bounds.insetBy(dx: -spread, dy: -spread)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        shadowPath = path.cgPath
    }
}

#endif
