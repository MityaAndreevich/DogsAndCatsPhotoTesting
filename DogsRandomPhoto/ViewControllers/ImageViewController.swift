//
//  ImageViewController.swift
//  CryptoCurrencyRateApp
//
//  Created by Dmitry Logachev on 27.09.2021.
//

import UIKit

class ImageViewController: UIViewController {
    
    
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var dogs: Dogs!
    var cats: DogsV2!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
}

extension ImageViewController {
    func fetchDogImage() {
        NetworkManager.shared.fetch(dataType: Dogs.self, from: Link.dogImage.rawValue) { result in
            switch result {
            case .success(let dog):
                NetworkManager.shared.fetchImage(from: dog.message) { result in
                    switch result {
                    case .success(let dogImage):
                        self.animalImageView.image = UIImage(data: dogImage)
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchDogV2Image() {
        NetworkManager.shared.fetch(dataType: DogsV2.self, from: Link.dogV2Image.rawValue) { result in
            switch result {
            case .success(let dog):
                NetworkManager.shared.fetchImage(from: dog.url) { result in
                    switch result {
                    case .success(let dogV2Image):
                        DispatchQueue.main.async {
                            self.animalImageView.image = UIImage(data: dogV2Image)
                            self.animalImageView.reloadInputViews()
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

