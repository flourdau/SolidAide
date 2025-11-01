//
//  TimeBankClass.swift
//  SolidAide
//
//  Created by apprenant78 on 27/10/2025.
//

import SwiftUI
import SwiftData

@Model
class TimeBankClass: Identifiable {
    var id = UUID()
    var userId: UserClass
    var date: Date
    var iconName: String
    //  iconColor
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double //
    var deposit: Int
    var withdrawal: Int
    var title: String
    var subtitle: String
    
    init(
        userId: UserClass,
        date: Date,
        iconName: String,
        iconColor: Color,
        deposit: Int,
        withdrawal: Int,
        title: String,
        subtitle: String
    ) {
        self.userId = userId
        self.date = date
        self.iconName = iconName
        self.deposit = deposit
        self.withdrawal = withdrawal
        self.title = title
        self.subtitle = subtitle
        let uiColor = UIColor(iconColor)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        
        if uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) {
            self.red = Double(r)
            self.green = Double(g)
            self.blue = Double(b)
            self.alpha = Double(a)
        }
        else {
            self.red = 0.5
            self.green = 0.5
            self.blue = 0.5
            self.alpha = 1.0
        }
    }
    
    var swiftUIColor: Color {
        get {  return Color(red: red, green: green, blue: blue, opacity: alpha) }
        
        set {
            let uiColor = UIColor(newValue)
            var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
            
            if uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) {
                self.red = Double(r)
                self.green = Double(g)
                self.blue = Double(b)
                self.alpha = Double(a)
            }
            
        }
        
    }
    
}
