//
//  PanoramaViewController.swift
//  MireaProject
//
//  Created by Дарья Никитина on 11.06.2024.
//

import UIKit
import YandexMapsMobile

class PanoramaViewController: UIViewController {
    var position: YMKPoint!
    var panoView: YMKPanoView!
    var panoramaSession: YMKPanoramaServiceSearchSession?

    override func viewDidLoad() {
        super.viewDidLoad()

        panoView = YMKPanoView(frame: view.frame, vulkanPreferred: true)
        view.addSubview(panoView)

        let responseHandler = { (panoramaIdResponse: String?, error: Error?) -> Void in
            if let panoramaId = panoramaIdResponse {
                self.onPanoramaFound(panoramaId)
            } else {
                self.onPanoramaSearchError(error!)
            }
        }

        let panoramaService = YMKPlacesFactory.instance().createPanoramaService()
        panoramaSession = panoramaService.findNearest(withPosition: position,
                                                      searchHandler: responseHandler)
    }

    func onPanoramaFound(_ panoramaId: String) {
        panoView.player.openPanorama(withPanoramaId: panoramaId)
        panoView.player.enableMove()
        panoView.player.enableRotation()
        panoView.player.enableZoom()
        panoView.player.enableMarkers()
    }

    func onPanoramaSearchError(_ error: Error) {
        print("Ошибочка:", error.localizedDescription)
    }
}
