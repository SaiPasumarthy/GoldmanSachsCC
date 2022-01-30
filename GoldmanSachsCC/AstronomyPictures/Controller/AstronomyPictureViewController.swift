//
//  AstronomyPictureViewController.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import UIKit
import CoreData

/**
 AstronomyPictureViewController
 which will display the astronomy pictures
*/
class AstronomyPictureViewController: UIViewController, AstronomyPicturesBaseCoordinated {
    @IBOutlet weak var astronomyPictureTableView: UITableView!
    var astronomyPictureViewModel: AstronomyPictureViewModel!
    var coordinator: AstronomyPicturesBaseCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBarbuttonItems()
        loadTableViewCell()
        astronomyPictureViewModel = AstronomyPictureViewModel()
        bindViewModel()
        astronomyPictureViewModel.getAstronomyPictureOfTheDay()
    }
}

extension AstronomyPictureViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.astronomyPictureViewModel.pictureArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AstronomyPictureTableViewCell") as! AstronomyPictureTableViewCell
        if let astronomyPictures = self.astronomyPictureViewModel.pictureArray {
            cell.pictureCellDelegate = self
            cell.updateAstronomyPicture(astronomyPicture: astronomyPictures[indexPath.row])
        }
      
        return cell
    }
}

extension AstronomyPictureViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        astronomyPictureTableView.reloadData()
    }
}

extension AstronomyPictureViewController: CoordinatorBoard { }

extension AstronomyPictureViewController: SearchAstronomyPicturesDelegate {
    func searchAstronomyPictures(from startDate: String, to endDate: String) {
        astronomyPictureViewModel.getAstronomyPictures(from: startDate, to: endDate)
    }
}

extension AstronomyPictureViewController: AstronomyPictureCellDelegate {
    func updateFavourites(for cell: AstronomyPictureTableViewCell) {
        guard let indexPath = astronomyPictureTableView.indexPath(for: cell) else { return }
        let astronomyPicture = astronomyPictureViewModel.pictureArray[indexPath.row]
        
        if astronomyPicture.favourite {
            astronomyPictureViewModel.removeFromFavourites(astronomyPicture: astronomyPicture)
        } else {
            astronomyPictureViewModel.addToFavourites(astronomyPicture: astronomyPicture)
        }        
    }
}

private extension AstronomyPictureViewController {
    
    func loadBarbuttonItems() {
        let searchBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search"), style: .plain, target: self, action: #selector(navigateToSearchScreen))
        let apodBarButtonItem = UIBarButtonItem(title: "APOD", style: .plain, target: self, action: #selector(getAstronomyPictureOfTheDay))
        
        self.navigationItem.rightBarButtonItems = [searchBarButtonItem, apodBarButtonItem]
    }
    
    func loadTableViewCell() {
        astronomyPictureTableView.register(UINib(nibName: "AstronomyPictureTableViewCell", bundle: nil), forCellReuseIdentifier: "AstronomyPictureTableViewCell")
    }
    
    func bindViewModel() {
        astronomyPictureViewModel.bindAstronomyPictureVM = { [weak self] in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                strongSelf.astronomyPictureTableView.reloadData()
            }
        }
        
        astronomyPictureViewModel.bindErrorResponse = { [weak self] in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                strongSelf.showAlert()
            }
        }
    }
    
    func showAlert() {
        let alertViewController = UIAlertController(title: "Error", message: astronomyPictureViewModel.errorResponse.msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertViewController.addAction(alertAction)
        self.present(alertViewController, animated: false, completion: nil)
    }
    
    @objc func getAstronomyPictureOfTheDay(_ sender: Any) {
        astronomyPictureViewModel.getAstronomyPictureOfTheDay()
    }
    
    @objc func navigateToSearchScreen(_ sender: Any) {
        coordinator?.navigateToSearchScreen()
    }
}
