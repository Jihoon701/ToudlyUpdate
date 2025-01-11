//
//  UIFont.swift
//  Todo
//
//  Created by 김지훈 on 2022/04/17.
//

import Foundation
import UIKit

extension UIFont {
    
    public enum NanumSquareRound: String {
        case light = "L"
        case regular = "R"
        case bold = "B"
        case extraBold = "EB"
    }
    
    public enum Manrope: String {
        case extraLight = "ExtraLight"
        case light = "Light"
        case regular = "Regular"
        case medium = "Medium"
        case semiBold = "SemiBold"
        case bold = "Bold"
        case extraBold = "ExtraBold"
    }
    
    public enum Suit: String {
        case thin = "Thin"
        case extraLight = "ExtraLight"
        case light = "Light"
        case regular = "Regular"
        case medium = "Medium"
        case semiBold = "SemiBold"
        case bold = "Bold"
        case extraBold = "ExtraBold"
        case heavy = "Heavy"
    }
    
    public enum NanumBarunGothic: String {
        case ultraLight = "UltraLight"
        case light = "Light"
        case regular = ""
        case bold = "Bold"
        
    }
    
    static func nanumSRFont(_ type: NanumSquareRound, size: CGFloat) -> UIFont {
        return UIFont(name: "NanumSquareRoundOTF\(type.rawValue)", size: size)!
    }
    
    static func manropeFont(_ type: Manrope, size: CGFloat) -> UIFont {
        return UIFont(name: "Manrope-\(type.rawValue)", size: size)!
    }
    
    static func suitFont(_ type: Suit, size: CGFloat) -> UIFont {
        return UIFont(name: "SUIT-\(type.rawValue)", size: size)!
    }
    
    static func nanumBGFont(_ type: NanumBarunGothic, size: CGFloat) -> UIFont {
        return UIFont(name: "NanumBarunGothic\(type.rawValue)", size: size)!
    }
}

class FontManager {
    enum SelectedFontType: String {
        case nanumSquareRound = "NanumSquareRound"
        case manrope = "Manrope"
        case suit = "Suit"
        case nanumBarunGothic = "NanumBarunGothic"
    }
    
    static var selectedFontType: SelectedFontType {
        get {
            if let fontTypeRawValue = UserDefaults.standard.string(forKey: "SelectedFontType"),
               let fontType = SelectedFontType(rawValue: fontTypeRawValue) {
                return fontType
            }
            return .nanumSquareRound
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "SelectedFontType")
        }
    }
    
    static var selectedRegularFont: UIFont {
        get {
            switch selectedFontType {
            case .nanumSquareRound:
                return UIFont.nanumSRFont(.regular, size: UIFont.systemFontSize)
            case .manrope:
                return UIFont.manropeFont(.regular, size: UIFont.systemFontSize)
            case .suit:
                return UIFont.suitFont(.regular, size: UIFont.systemFontSize)
            case .nanumBarunGothic:
                return UIFont.nanumBGFont(.light, size: UIFont.systemFontSize)
            }
        }
    }
    
    static var selectedBoldFont: UIFont {
        get {
            switch selectedFontType {
            case .nanumSquareRound:
                return UIFont.nanumSRFont(.bold, size: UIFont.systemFontSize)
            case .manrope:
                return UIFont.manropeFont(.medium, size: UIFont.systemFontSize)
            case .suit:
                return UIFont.suitFont(.bold, size: UIFont.systemFontSize)
            case .nanumBarunGothic:
                return UIFont.nanumBGFont(.regular, size: UIFont.systemFontSize)
            }
        }
    }
    
    static var selectedExtraBoldFont: UIFont {
        get {
            switch selectedFontType {
            case .nanumSquareRound:
                return UIFont.nanumSRFont(.extraBold, size: UIFont.systemFontSize)
            case .manrope:
                return UIFont.manropeFont(.semiBold, size: UIFont.systemFontSize)
            case .suit:
                return UIFont.suitFont(.extraBold, size: UIFont.systemFontSize)
            case .nanumBarunGothic:
                return UIFont.nanumBGFont(.bold, size: UIFont.systemFontSize)
            }
        }
    }
}

extension UIFont {
    static func appRegularFont(_ size: CGFloat) -> UIFont {
        return FontManager.selectedRegularFont.withSize(size)
    }
    
    static func appBoldFont(_ size: CGFloat) -> UIFont {
        return FontManager.selectedBoldFont.withSize(size)
    }
    
    static func appExtraBoldFont(_ size: CGFloat) -> UIFont {
        return FontManager.selectedExtraBoldFont.withSize(size)
    }
}

