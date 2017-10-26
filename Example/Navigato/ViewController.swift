//
//  ViewController.swift
//  Navigato
//
//  Created by anatoliy.voropay@gmail.com on 10/26/2017.
//  Copyright (c) 2017 anatoliy.voropay@gmail.com. All rights reserved.
//

import UIKit
import CoreLocation
import Navigato

class ViewController: UIViewController {

    @IBAction func pressedAddress(sender: AnyObject) {
        openSourceApp(address: "1 Infinite Loop, Cupertino, CA 95014, USA")
    }

    @IBAction func pressedLocation(sender: AnyObject) {
        let location = CLLocation(latitude: 51.7520, longitude: -1.2577)
        openSourceApp(location: location)
    }

    @IBAction func pressedSearch(sender: AnyObject) {
        openSourceApp(search: "Empire State Building")
    }

    private func openSourceApp(address: String? = nil, location: CLLocation? = nil, search: String? = nil) {
        let alertController = UIAlertController(
            title: "Select App",
            message: "Select navigation application to be used",
            preferredStyle: .actionSheet)

        // Add this to test on iPad
        // alertController.popoverPresentationController?.sourceView = nil
        // alertController.popoverPresentationController?.sourceRect = .zero
        // alertController.popoverPresentationController?.permittedArrowDirections = .any

        alertController.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel) { _ in })

        let navigato = Navigato()
        navigato.apps.forEach { (app) in
            alertController.addAction(UIAlertAction(
                title: app.name,
                style: .default) { _ in
                    if let address = address {
                        app.open(withAddress: address)
                    } else if let search = search {
                        app.open(withQuery: search)
                    } else if let location = location {
                        app.open(withLocation: location)
                    }
                })
        }

        present(alertController, animated: true) { }
    }

}

