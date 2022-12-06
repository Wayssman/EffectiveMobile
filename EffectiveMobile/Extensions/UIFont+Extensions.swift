//
//  UIFont+Extensions.swift
//  EffectiveMobile
//
//  Created by Alexandr on 06.12.2022.
//

import UIKit

extension UIFont {
    static func markPro(_ weight: Weight, _ size: CGFloat) -> UIFont {
        switch weight {
        case .bold:
            return UIFont(name: "MarkPro-Bold", size: size) ?? .systemFont(ofSize: size)
        case .medium:
            return UIFont(name: "MarkPro-Medium", size: size) ?? .systemFont(ofSize: size)
        case .regular:
            return UIFont(name: "MarkPro-Regular", size: size) ?? .systemFont(ofSize: size)
        case .heavy:
            return UIFont(name: "MarkPro-Heavy", size: size) ?? .systemFont(ofSize: size)
        default:
            return .systemFont(ofSize: size)
        }
    }
}
