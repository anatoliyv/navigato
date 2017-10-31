//
//  Navigato.swift
//  Navigato
//
//  Created by Anatoliy Voropay on 10/26/17.
//

import Foundation

/// Used for routing to existing navigation and map apps.
public class Navigato {

    /// Different types of requests to navigation apps
    public enum RequestType {
        /// Request to open specific address
        case address
        /// Request to open specific location
        case location
        /// Request to open search by queary
        case search
    }

    /// Available navigation apps
    public private(set) var apps: [NavigatoSourceApp] = []

    // MARK: Lifecycle

    public convenience init() {
        self.init(withApps: Navigato.availableApps)
    }

    public init(withApps apps: [NavigatoSourceApp]) {
        self.apps = apps
    }

    // MARK: Source Apps

    /// Return array of all supported Source Apps
    class var supportedApps: [NavigatoSourceApp] {
        return [
            NavigatoMaps(),
            NavigatoGoogleMaps(),
            NavigatoWaze(),
        ]
    }

    /// Return array of available Source Apps
    class var availableApps: [NavigatoSourceApp] {
        return Navigato.supportedApps.filter { $0.isAvailable }
    }
}
