//
//  NavigatoWaze.swift
//  Navigato
//
//  Created by Anatoliy Voropay on 10/31/17.
//

import Foundation

/// Waze maps source type for `Navigato`
public class NavigatoWaze: NavigatoSourceApp {

    public override var name: String {
        return "Waze"
    }

    override public var isAvailable: Bool {
        guard let url = URL(string: "waze://") else { return false }
        return UIApplication.shared.canOpenURL(url)
    }

    public override func path(forRequest request: Navigato.RequestType) -> String {
        switch request {
        case .address:
            return "https://waze.com/ul?q="

        case .location:
            return "waze://?ll="

        case .search:
            return "https://waze.com/ul?q="
        }
    }
}
