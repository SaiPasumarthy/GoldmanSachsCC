//
//  SearchAstronomyPicturesDelegate.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 30/01/22.
//

import Foundation

/// This protocol which communicates to parent from the SearchAstronomyPictureViewController
protocol SearchAstronomyPicturesDelegate: AnyObject {
    func searchAstronomyPictures(from: String, to: String)
}
