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
    var cats: Cats!
    
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
    
    func fetchCatImage() {
        NetworkManager.shared.fetch(dataType: Cats.self, from: Link.catImage.rawValue) { result in
            switch result {
            case .success(let cat):
                NetworkManager.shared.fetchImage(from: cat.url) { result in
                    switch result {
                    case .success(let catImage):
                        DispatchQueue.main.async {
                            self.animalImageView.image = UIImage(data: catImage)
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
    
    func printD() {
        print(1)
    }
    
    func printC() {
        print(2)
    }
}

