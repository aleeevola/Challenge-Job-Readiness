//
//  StringExtension.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 20/09/2022.
//

import Foundation

extension String {
#warning("Fail Fast concept, if has to fail, better doing sooner than later, helps to identify reject cases")
  func currencyFormatting() -> String {
    guard let value = Double(self) else { return "" }
    
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "es_AR" )
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    
    return formatter.string(for: value) ?? ""
  }
}
