//
//  NavigatoMaps.swift
//  Navigato
//
//  Created by Anatoliy Voropay on 10/26/17.
//

import Foundation

/// Apple maps source type for `Navigato`
public class NavigatoMaps: NavigatoSourceApp {

    public override var name: String {
        return "Maps"
    }

    public override func path(forRequest request: Navigato.RequestType) -> String {
        switch request {
        case .address:
            return "http://maps.apple.com/?address="

        case .location:
            return "http://maps.apple.com/?ll="

        case .search:
            return "http://maps.apple.com/?q="
        }
    }
}
