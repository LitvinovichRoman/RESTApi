import Foundation
import UIKit

extension UIView {
    func roundElement () {
        layer.cornerRadius = 25
        layer.masksToBounds = true
    }
    
    func roundElementIntHeight() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
}
