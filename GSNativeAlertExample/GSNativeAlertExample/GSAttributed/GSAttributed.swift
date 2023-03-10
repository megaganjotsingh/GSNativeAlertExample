//
//  Attributed.swift
//  CustomAlert
//
//  Created by Gaganjot Singh on 21/10/22.
//

import Foundation
import UIKit

class GSAttributed<Base> {
    let base: Base
    
    var attributesDict: [NSAttributedString.Key: Any] = [:]
    
    init(_ base: Base) {
        self.base = base
    }
}

protocol GSAttributedCompatible {
    associatedtype CompatibleType
    var attributed: CompatibleType { get }
}
 
extension GSAttributedCompatible {
    var attributed: GSAttributed<Self> {
        GSAttributed(self)
    }
}

extension String: GSAttributedCompatible {}
extension NSAttributedString: GSAttributedCompatible {}

extension GSAttributed {
    @discardableResult
    func font(_ font: UIFont?) -> Self {
        attributesDict[.font] = font
        return self
    }
    
    @discardableResult
    func foregroundColor(_ color: UIColor) -> Self {
        attributesDict[.foregroundColor] = color
        return self
    }
    
    public func kerning(_ kerning: Double) -> Self {
        attributesDict[NSAttributedString.Key.kern] =  NSNumber(floatLiteral: kerning)
        return self
    }

    public func strikeThroughStyle(_ strikeThroughStyle: NSUnderlineStyle) -> Self {
        attributesDict[NSAttributedString.Key.strikethroughStyle] = strikeThroughStyle.rawValue
        attributesDict[NSAttributedString.Key.baselineOffset] = NSNumber(floatLiteral: 1.5)
        return self
    }

    public func underlineStyle(_ underlineStyle: NSUnderlineStyle) -> Self {
        attributesDict[NSAttributedString.Key.underlineStyle] =  underlineStyle.rawValue
        return self
    }

    public func strokeColor(_ strokeColor: UIColor) -> Self {
        attributesDict[NSAttributedString.Key.strokeColor] =  strokeColor
        return self
    }

    public func strokeWidth(_ strokewidth: Double) -> Self {
        attributesDict[NSAttributedString.Key.strokeWidth] = NSNumber(floatLiteral: strokewidth)
        return self
    }

    public func foreground(color: UIColor) -> Self {
        attributesDict[NSAttributedString.Key.foregroundColor] = color
        return self
    }

    public func background(color: UIColor) -> Self {
        attributesDict[NSAttributedString.Key.backgroundColor] = color
        return self
    }

    public func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> Self {
        attributesDict[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        return self
    }

    public func shadow(_ shadow: NSShadow) -> Self {
        attributesDict[NSAttributedString.Key.shadow] = shadow
        return self
    }

    public func obliqueness(_ value: CGFloat) -> Self {
        attributesDict[NSAttributedString.Key.obliqueness] = value
        return self
    }

    public func link(_ link: String) -> Self {
        attributesDict[NSAttributedString.Key.link] = link
        return self
    }

    public func baselineOffset(_ offset: NSNumber) -> Self {
        attributesDict[NSAttributedString.Key.baselineOffset] = offset
        return self
    }

    // MARK: NSParagraphStyle related

    public func lineSpacing(_ lineSpacing: CGFloat) -> Self {
        let paragraphStyle = (attributesDict[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.lineSpacing = lineSpacing
        attributesDict[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        return self
    }

    public func paragraphSpacing(_ paragraphSpacing: CGFloat) -> Self {
        let paragraphStyle = (attributesDict[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.paragraphSpacing =  paragraphSpacing
        attributesDict[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        return self
    }

    public func alignment(_ alignment: NSTextAlignment) -> Self {
        let paragraphStyle = (attributesDict[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.alignment = alignment
        attributesDict [NSAttributedString.Key.paragraphStyle] = paragraphStyle
        return self
    }

    public func firstLineHeadIndent(_ firstLineHeadIndent: CGFloat) -> Self {
        let paragraphStyle = (attributesDict[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.firstLineHeadIndent = firstLineHeadIndent
        attributesDict [NSAttributedString.Key.paragraphStyle] = paragraphStyle
        return self
    }

    public func headIndent(_ headIndent: CGFloat) -> Self {
        let paragraphStyle = (attributesDict[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.headIndent = headIndent
        attributesDict [NSAttributedString.Key.paragraphStyle] = paragraphStyle
        return self
    }

    public func tailIndent(_ tailIndent: CGFloat) -> Self {
        let paragraphStyle = (attributesDict[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.tailIndent = tailIndent
        attributesDict [NSAttributedString.Key.paragraphStyle] = paragraphStyle
        return self
    }

    public func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Self {
        let paragraphStyle = (attributesDict[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = lineBreakMode
        attributesDict [NSAttributedString.Key.paragraphStyle] = paragraphStyle
        return self
    }

    public func minimumLineHeight(_ minimumLineHeight: CGFloat) -> Self {
        let paragraphStyle = (attributesDict[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.minimumLineHeight = minimumLineHeight
        attributesDict [NSAttributedString.Key.paragraphStyle] = paragraphStyle
        return self
    }

    public func maximumLineHeight(_ maximumLineHeight: CGFloat) -> Self {
        let paragraphStyle = (attributesDict[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.maximumLineHeight = maximumLineHeight
        attributesDict [NSAttributedString.Key.paragraphStyle] = paragraphStyle
        return self
    }

    public func uniformLineHeight(_ uniformLineHeight: CGFloat) -> Self {
        return maximumLineHeight(uniformLineHeight).minimumLineHeight(uniformLineHeight)
    }

    public func baseWritingDirection(_ baseWritingDirection: NSWritingDirection) -> Self {
        let paragraphStyle = (attributesDict[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.baseWritingDirection = baseWritingDirection
        attributesDict [NSAttributedString.Key.paragraphStyle] = paragraphStyle
        return self
    }

    public func lineHeightMultiple(_ lineHeightMultiple: CGFloat) -> Self {
        let paragraphStyle = (attributesDict[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        attributesDict [NSAttributedString.Key.paragraphStyle] = paragraphStyle
        return self
    }

    public func paragraphSpacingBefore(_ paragraphSpacingBefore: CGFloat) -> Self {
        let paragraphStyle = (attributesDict[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.paragraphSpacingBefore = paragraphSpacingBefore
        attributesDict [NSAttributedString.Key.paragraphStyle] = paragraphStyle
        return self
    }

    public func hyphenationFactor(_ hyphenationFactor: Float) -> Self {
        let paragraphStyle = (attributesDict[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.hyphenationFactor = hyphenationFactor
        attributesDict[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        return self
    }
}

extension GSAttributed where Base == String {
    func make() -> NSAttributedString {
        NSAttributedString(string: base, attributes: attributesDict)
    }
}

extension GSAttributed where Base == NSMutableAttributedString {
    @discardableResult
    func make(to range: NSRange) -> NSAttributedString {
        base.addAttributes(attributesDict, range: range)
        return base
    }
}

extension GSAttributed where Base == NSAttributedString {

    func make(for range: NSRange) -> NSAttributedString {
        let string = base as NSAttributedString
        let result = NSMutableAttributedString(attributedString: string)
        result.addAttributes(attributesDict, range: range)
        return base
    }
}
