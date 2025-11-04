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
    var date: Date
    var minutes: Int
    var createdAt: Date
    var details: String?
    var iconName: String
    //  iconColor
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double

    var title: String
    var subtitle: String
    
    init(
        date: Date,
        minutes: Int,
        createdAt: Date = .now,
        details: String? = nil,
        iconName: String,
        iconColor: Color,
        title: String,
        subtitle: String
    ) {
        self.date = date
        self.minutes = minutes
        self.createdAt = createdAt
        self.details = details
        self.iconName = iconName
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
        get {
            return Color(red: red, green: green, blue: blue, opacity: alpha)
        }

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
