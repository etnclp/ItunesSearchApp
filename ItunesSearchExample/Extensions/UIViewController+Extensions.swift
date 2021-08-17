//
//  UIViewController+Extensions.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 17.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import UIKit

extension UIViewController {

    /// Helper method to display an alert on any UIViewController subclass. Uses UIAlertController to show an alert
    ///
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message/body of the alert
    ///   - showCancel: (Optional)whether to show cancel button
    ///   - completion: (Optional) completion block to be invoked when any one of the buttons is tapped. It passes the index of the tapped button as an argument
    func showAlert(message: String, title: String? = "Error", showCancel: Bool = false, completion: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            completion?()
        }))
        if showCancel == true {
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        }
        DispatchQueue.main.async {
            guard !(self.presentedViewController is UIAlertController) else { return }
            self.present(alertVC, animated: true, completion: nil)
        }
    }

}
