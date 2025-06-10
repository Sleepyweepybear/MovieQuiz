import UIKit

extension UIColor {
    static var yp_Red: UIColor { return UIColor(named: "YP_Red") ?? .red }
    static var yp_Green: UIColor { return UIColor(named: "YP_Green") ?? .green }
    static var yp_Background: UIColor { return UIColor(named: "YP_Background") ?? .darkGray }
    static var yp_Gray: UIColor { return UIColor(named: "YP_Gray") ?? .gray }
    static var yp_White: UIColor { return UIColor(named: "YP_White") ?? .white }
    static var yp_Black: UIColor { return UIColor(named: "YP_Black") ?? .black }
}

extension UIFont {
    public enum YSDisplayType: String {
        case regular = ""
        case FontBold = "YSDisplay-Bold"
        case FontMedium = "YSDisplay-Medium"
    }
    
    static func setFont(_ type: YSDisplayType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
        var isBold: Bool {
               return fontDescriptor.symbolicTraits.contains(.traitBold)
           }
    }

