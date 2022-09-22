//
//  StringExtension.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 20/09/2022.
//

import Foundation

extension String {
    func currencyFormatting() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "es_AR" )
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
}
