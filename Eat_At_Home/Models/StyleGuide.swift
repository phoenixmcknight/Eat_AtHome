//
//  StyleGuide.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/28/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//


import UIKit

enum StyleGuide {
    
    // MARK: - For Headers: App Name
    enum TitleFontStyle{
        static let fontName = "CopperPlate"
        static let fontColor: UIColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        static let fontSize:CGFloat = 50
        static let altFontSize: CGFloat = 25
    }
    
    // MARK: -  For Labels
    enum FontStyle {
        static let fontName = "Helvetica-Neue"
        static let fontSize: CGFloat = 12
        static let altFontSize: CGFloat = 25
        static let fontColor: UIColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
    }
    // MARK: - For All App Colors
    enum AppColors{
        static let primaryColor: UIColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        static let accentColor: UIColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        static let disabledColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        static let backgroundColor: UIColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
    }
    
    // MARK: -  For Placeholder Images
    enum ImageStrings {
        static let placeHolder = "photo"
    }
    
    //  MARK: - For All Buttons
    enum ButtonStyle {
        static let fontName = "CopperPlate"
        static let borderColor: CGColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        static let fontColor: UIColor = #colorLiteral(red: 0.9534531236, green: 0.3136326671, blue: 1, alpha: 1)
        static let disabledColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        static let backgroundColor: UIColor = .clear
        static let fontSize: CGFloat = 20
        static let altFontSize: CGFloat = 14
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 4
        static let altBorderWidth: CGFloat = 2
        
    }
    //For All Textfields
    enum TextFieldStyle {
        static let backgroundColor: UIColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        static let fontName = "Helvetica-Neue"
        static let fontSize: CGFloat = 14
    }
    
    
}
