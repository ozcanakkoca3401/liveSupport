//
//  CoreColors.swift
//  
//
//  Created by Ozcan Akkoca on 7.01.2024.
//

import UIKit

public struct CoreColors {
    public static var black11: UIColor { Colors.black11.asUIColor }
    public static var border11: UIColor { Colors.border11.asUIColor }
    public static var gray11: UIColor { Colors.gray11.asUIColor }
    public static var purple11: UIColor { Colors.purple11.asUIColor }
    public static var lightPurple11: UIColor { Colors.lightPurple11.asUIColor }
    public static var white11: UIColor { Colors.white11.asUIColor }
}

public enum Colors: String {
    case black11
    case border11
    case gray11
    case purple11
    case lightPurple11
    case white11
}

extension Colors {
    public var asUIColor: UIColor {
        guard let colorAsset = UIColor(
            named: rawValue,
            in: Bundle.module,
            compatibleWith: nil
        ) else {
            assertionFailure("[CoreResource] No color with \(rawValue) in the color assets")
            return .unknownColor
        }
        return colorAsset
    }

    public var asCGColor: CGColor {
        asUIColor.cgColor
    }
}

/// Define unknown color
extension UIColor {
    static let unknownColor = UIColor.clear
}
