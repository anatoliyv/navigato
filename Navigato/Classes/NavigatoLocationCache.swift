//
//  NavigatoLocationCache.swift
//  Navigato
//
//  Created by Anatoliy Voropay on 10/31/17.
//

import Foundation
import CoreLocation

/// Class used to cache location by address
public class NavigatoLocationCache {

    /// Address to location cache
    fileprivate var locations: [String:CLLocation] = [:]

    /// Address to placemeark cache
    fileprivate var placemarks: [String:CLPlacemark] = [:]

    // MARK: Lifecycle

    /// Cache location by address
    func cache(address: String) {
        cache(addresses: [address])
    }

    /// Cache location by array of addresses strings
    func cache(addresses: [String]) {
        addresses.forEach({ (address) in
            location(byAddress: address, completion: { _ in })
        })
    }

    // MARK: Location

    /// Get `CLLocation` by address. If address already is in our cache no actual request to
    /// `CLGeocoder` will be performed and we will use cached value.
    func location(byAddress address: String, completion: @escaping (CLLocation?) -> Void) {
        if let location = locations[address] {
            DispatchQueue.main.async {
                completion(location)
            }
            return
        }

        performCache(forAddress: address) { (_, location) in
            completion(location)
        }
    }

    func cachedLocation(byAddress address: String) -> CLLocation? {
        if let location = locations[address] {
            return location
        }

        return nil
    }

    // MARK: Placemark

    /// Get `CLPlacemark` by address. If address already is in our cache no actual request to
    /// `CLGeocoder` will be performed and we will use cached value.
    func placement(byAddress address: String, completion: @escaping (CLPlacemark?) -> Void) {
        if let placemark = placemarks[address] {
            DispatchQueue.main.async {
                completion(placemark)
            }
            return
        }

        performCache(forAddress: address) { (placemark, _) in
            completion(placemark)
        }
    }

    func cachedPlacemark(byAddress address: String) -> CLPlacemark? {
        if let placemark = placemarks[address] {
            return placemark
        }

        return nil
    }

    // MARK: Actual cache

    private func performCache(forAddress address: String, completion: @escaping (CLPlacemark?, CLLocation?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: { [weak self] (placemarks, error) in
            if  let strongSelf = self,
                let placemark = placemarks?.first,
                let location = placemark.location
            {
                DispatchQueue.main.async {
                    strongSelf.locations[address] = location
                    strongSelf.placemarks[address] = placemark
                    completion(placemark, location)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, nil)
                }
            }
        })
    }
}
