//
//  FavouritesViewController.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import UIKit

/// FavouritesViewController which will display the favourites
class FavouritesViewController: UIViewController {
    @IBOutlet weak var favouritesTableView: UITableView!
    var favouritesViewModel: FavouritesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableViewCell()
        favouritesViewModel = FavouritesViewModel()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favouritesViewModel.getFavouritePictures()
    }
}

extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favouritesViewModel.favouritesArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AstronomyPictureTableViewCell") as! AstronomyPictureTableViewCell
        if let astronomyPictures = self.favouritesViewModel.favouritesArray {
            cell.pictureCellDelegate = self
            cell.updateAstronomyPicture(astronomyPicture: astronomyPictures[indexPath.row])
        }
        
        return cell
    }
}

extension FavouritesViewController: AstronomyPictureCellDelegate {
    func updateFavourites(for cell: AstronomyPictureTableViewCell) {
        guard let indexPath = favouritesTableView.indexPath(for: cell) else { return }
        let astronomyPicture = favouritesViewModel.favouritesArray[indexPath.row]
        favouritesViewModel.removeFromFavourites(astronomyPicture: astronomyPicture)
    }
}

extension FavouritesViewController: CoordinatorBoard { }

private extension FavouritesViewController {
    func bindViewModel() {
        favouritesViewModel.bindFavouritesVM = { [weak self] in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                strongSelf.favouritesTableView.reloadData()
            }
        }
    }
    
    func loadTableViewCell() {
        favouritesTableView.register(UINib(nibName: "AstronomyPictureTableViewCell", bundle: nil), forCellReuseIdentifier: "AstronomyPictureTableViewCell")
    }
}
