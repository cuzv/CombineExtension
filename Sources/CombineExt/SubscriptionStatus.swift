//
//  File.swift
//  
//
//  Created by Shaw on 12/16/19.
//

import Foundation
import Combine

enum SubscriptionStatus {
    case awaitingSubscription
    case subscribed(Subscription)
    case terminal
}
