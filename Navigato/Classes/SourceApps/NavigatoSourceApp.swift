//
//  NavigatoSourceApp.swift
//  Navigato
//
//  Created by Anatoliy Voropay on 10/26/17.
//

import Foundation
import CoreLocation

/// Protocol to describe Source App behaviour for Navigato
public protocol NavigatoSourceAppProtocol {

    /// Source app name
    var name: String { get }

    /// Return `true` if source app is available
    var isAvailable: Bool { get }

    /// Open source app with address String
    func open(withAddress address: String)

    /// Open source app with `CLLocation`
    func open(withLocation location: CLLocation)

    /// Open source app with search query
    func open(withQuery query: String)

    // MARK: Low-level interface

    /// Return path for request
    func path(forRequest request: Navigato.RequestType) -> String

    /// Open source app with specific `Navigato.RequestType`
    func open(withRequest request: Navigato.RequestType, value: Any)
}

/// Base class for all Source App subclasses
public class NavigatoSourceApp: NavigatoSourceAppProtocol {

    public var name: String {
        assertionFailure("Implementation required")
        return ""
    }

    public func path(forRequest request: Navigato.RequestType) -> String {
        assertionFailure("Implementation required")
        return ""
    }

    /// Return `true` if source app is available
    public var isAvailable: Bool {
        let path = self.path(forRequest: .address)
        guard let url = URL(string: path) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }

    /// Open source app with address String
    public func open(withAddress address: String) {
        open(withRequest: .search, value: address as Any)
    }

    /// Open source app with `CLLocation`
    public func open(withLocation location: CLLocation) {
        open(withRequest: .location, value: location as Any)
    }

    /// Open source app with search query
    public func open(withQuery query: String) {
        open(withRequest: .search, value: query as Any)
    }

    public func open(withRequest request: Navigato.RequestType, value: Any) {
        let path = self.path(forRequest: request)
        var destinationURL: URL?

        switch request {
        case .address, .search:
            guard let string = (value as? String)?.addingPercentEncoding(withAllowedCharacters: queryCharacterSet) else { return }
            destinationURL = URL(string: path + string)

        case .location:
            guard let location = value as? CLLocation else { return }
            let string = [location.coordinate.latitude, location.coordinate.longitude].map({ String($0) }).joined(separator: ",")
            destinationURL = URL(string: path + string)
        }

        guard let url = destinationURL else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.openURL(url)
    }

    private var queryCharacterSet: CharacterSet {
        let characterSet = NSMutableCharacterSet()
        characterSet.formUnion(with: CharacterSet.urlQueryAllowed)
        characterSet.removeCharacters(in: "&")
        return characterSet as CharacterSet
    }
}
