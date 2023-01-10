//
//  UIApplication+Extensions.swift
//  SettingsBundle_Sample
//
//  Created by Osman Yıldırım
//

import UIKit

extension UIApplication {
    static func openAppSettings() {
        let application = UIApplication.shared

        if let url = URL(string: UIApplication.openSettingsURLString), application.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                application.open(url, options: [:], completionHandler: nil)
            } else {
                application.openURL(url)
            }
        }
    }
}
