//
//  ImageViewController.swift
//  CryptoCurrencyRateApp
//
//  Created by Dmitry Logachev on 27.09.2021.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var dog: Dogs!
    private var cat: Cats!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        //fetchImageDog()
        //fetchImageCat()
    }
    
}

extension ImageViewController {
    
  func fetchImageDog() {
        guard let url = URL(string: Link.dogImage.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { [self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                self.dog = try JSONDecoder().decode(Dogs.self, from: data)
                guard let url2 = URL(string: dog.message ?? "") else { return }
                guard let imageData = try? Data(contentsOf: url2) else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                }
                DispatchQueue.main.async {
                    self.imageView.reloadInputViews()
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchImageCat() {
          guard let url = URL(string: Link.catImage.rawValue) else { return }
          
          URLSession.shared.dataTask(with: url) { [self] data, _, error in
              guard let data = data else {
                  print(error?.localizedDescription ?? "No error description")
                  return
              }
              do {
                  self.cat = try JSONDecoder().decode(Cats.self, from: data)
                  guard let url2 = URL(string: cat.url ?? "") else { return }
                  guard let imageData = try? Data(contentsOf: url2) else { return }
                  DispatchQueue.main.async {
                      self.imageView.image = UIImage(data: imageData)
                  }
                  DispatchQueue.main.async {
                      self.imageView.reloadInputViews()
                  }
                  
              } catch let error {
                  print(error.localizedDescription)
              }
          }.resume()
      }
}
