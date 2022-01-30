//
//  SearchAstronomyPictureViewController.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import UIKit

/**
 SearchAstronomyPictureViewController
 which will allow user to search the astronomy pictures
 between two dates
*/
class SearchAstronomyPictureViewController: UIViewController, AstronomyPicturesBaseCoordinated {
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var searchDatePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIView!
    var coordinator: AstronomyPicturesBaseCoordinator?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func selectTheStartDate(_ sender: Any) {
        pickerView.isHidden = false
        searchDatePicker.tag = 0
    }
    
    @IBAction func selectTheEndDate(_ sender: Any) {
        pickerView.isHidden = false
        searchDatePicker.tag = 1
    }
    
    @IBAction func pickTheDate(_ sender: Any) {
        setTheDate()
    }
    
    @IBAction func doneWithDatePicker(_ sender: Any) {
        pickerView.isHidden = true
        setTheDate()
    }

    @IBAction func searchTheAstronomyPictures(_ sender: Any) {
        if let startDate = startDateTextField.text!.getDateForString(), let endDate = endDateTextField.text!.getDateForString() {
            if startDate.compare(endDate) == .orderedDescending {
                showAlert()
                return
            }
            
            coordinator?.dismissSearchScreenWith(startDate: startDateTextField.text!, endDate: endDateTextField.text!)           
        }
    }
    
    @IBAction func dismissViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

private extension SearchAstronomyPictureViewController {
    func showAlert() {
        let alertViewController = UIAlertController(title: "Information", message: "The start date shouldn't be greater than end date. Please change and try again.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertViewController.addAction(alertAction)
        self.present(alertViewController, animated: false, completion: nil)
    }
    
    func setTheDate() {
        if searchDatePicker.tag == 0 {
            startDateTextField.text = searchDatePicker.date.getStringForDate()
            return
        }
        endDateTextField.text = searchDatePicker.date.getStringForDate()
    }
}

extension SearchAstronomyPictureViewController: CoordinatorBoard { }
