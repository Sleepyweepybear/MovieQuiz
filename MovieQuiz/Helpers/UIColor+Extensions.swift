import UIKit

extension UIColor {
    static var ypBlack: UIColor { UIColor(named: "YP Black") ?? UIColor.black }
    static var ypRed: UIColor { UIColor(named: "YP Red") ?? UIColor.red }
    static var ypGreen: UIColor { UIColor(named: "YP Green") ?? UIColor.green }
    static var ypBackground: UIColor { UIColor(named: "YP Background") ?? UIColor.darkGray }
    static var ypGray: UIColor { UIColor(named: "YP Black") ?? UIColor.gray }
    static var ypWhite: UIColor { UIColor(named: "YP White") ?? UIColor.white }
}

extension UILabel {
    static var ysMedium20: UIFont {
        UIFont(name: "YSDisplay-Medium", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .medium)
    }
    
    static var ysBold23: UIFont {
        UIFont(name: "YSDisplay-Bold", size: 23) ?? UIFont.systemFont(ofSize: 23, weight: .bold)
    }
    
    static var ysBold18: UIFont {
        UIFont(name: "YSDisplay-Bold", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    static var ysMedium16: UIFont {
        UIFont(name: "YSDisplay-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .medium)
    }
}

