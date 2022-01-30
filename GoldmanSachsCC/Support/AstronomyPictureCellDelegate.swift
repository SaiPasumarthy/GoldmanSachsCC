//
//  AstronomyPictureCellDelegate.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 30/01/22.
//

import Foundation

/**
    This protocol communicates between UITableViewCell and UIViewController
*/
protocol AstronomyPictureCellDelegate: AnyObject {
    func updateFavourites(for cell: AstronomyPictureTableViewCell)
}
