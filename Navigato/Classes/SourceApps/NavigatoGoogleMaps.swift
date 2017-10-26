//
//  NavigatoGoogleMaps.swift
//  Navigato
//
//  Created by Anatoliy Voropay on 10/26/17.
//

import Foundation

/// Google Maps source app for `Navigato`
public class NavigatoGoogleMaps: NavigatoSourceApp {

    public override var name: String {
        return "Google Maps"
    }

    public override func path(forRequest request: Navigato.RequestType) -> String {
        switch request {
        case .address:
            return "comgooglemaps://?saddr="

        case .location:
            return "comgooglemaps://?center="

        case .search:
            return "comgooglemaps://?q="
        }
    }
}
