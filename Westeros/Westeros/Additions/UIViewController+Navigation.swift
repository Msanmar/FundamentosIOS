//
//  UIViewController+Navigation.swift
//  Westeros
//
//  Created by Alexandre Freire on 13/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

// MARK: - UIViewController+Navigation
extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        // OJO! Esto crea una NUEVA instancia de UINavigationController
        return UINavigationController(rootViewController: self)
    }
}
