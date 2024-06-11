//
//  OSMMapsTileOverlay.swift
//  Lesson8
//
//  Created by Дарья Никитина on 08.06.2024.
//

import MapKit

class OSMMapsTileOverlay: MKTileOverlay {
    
    override func url(forTilePath path: MKTileOverlayPath) -> URL {
        return URL(string: "https://tile.openstreetmap.org/\(path.z)/\(path.x)/\(path.y).png")!
    }
}
