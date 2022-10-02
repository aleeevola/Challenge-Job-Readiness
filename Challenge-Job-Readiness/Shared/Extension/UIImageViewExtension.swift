//
//  UIImageViewExtension.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 20/09/2022.
//

import Foundation
import UIKit

extension UIImageView {
  
  func load(url: URL) {
    DispatchQueue.global().async { [weak self] in
      guard let data = try? Data(contentsOf: url) else { return }
      guard let image = UIImage(data: data) else { return }
      
      DispatchQueue.main.async {
        self?.image = image
      }
    }
  }
}
