//
//  NotificationName+Additions.swift
//  Westeros
//
//  Created by Alexandre Freire on 20/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Notification.Name+Additions
extension Notification.Name { //propiedad estática creada para todos los tipos Notification.Name
    static let houseDidNotificationName = Notification.Name("HouseDidNotificationName")
    static let seasonDidNotificationName = Notification.Name("SeasonDidNotificationName")
}
