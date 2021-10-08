//
//  MainViewController.swift
//  CryptoCurrencyRateApp
//
//  Created by Dmitry Logachev on 27.09.2021.
//

import UIKit

enum UserAction: String, CaseIterable {
    case downloadDogImage = "Download Image of a dog"
    case downloadCatImage = "Download Image of a cat"
    case getJSONWithDog = "Get JSON with dog"
    case getJSONWithCat = "Get JSON with cat"
}

class MainViewController: UICollectionViewController {
    
    let userActions = UserAction.allCases

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserActionCell
    
        let userAction = userActions[indexPath.item]
        cell.userActionName.text = userAction.rawValue
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.row]
        
        switch userAction {
        case .downloadDogImage: performSegue(withIdentifier: "showDogImage", sender: nil)
        case .downloadCatImage: performSegue(withIdentifier: "showCatImage", sender: nil)
        case .getJSONWithDog: getJSONWithDog()
        case .getJSONWithCat: getJSONWithCat()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let imageVC = segue.destination as! ImageViewController
        switch segue.identifier {
        case "showDogImage": imageVC.fetchDogImage()
        case "showCatImage": imageVC.fetchCatImage()
        default: break
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
    
extension MainViewController {
    
    private func getJSONWithDog() {
        NetworkManager.shared.fetch(dataType: Dogs.self, from: Link.dogImage.rawValue) { result in
            switch result {
            case .success(let dog):
                print(dog)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getJSONWithCat() {
        NetworkManager.shared.fetch(dataType: Cats.self, from: Link.catImage.rawValue) { result in
            switch result {
            case .success(let cat):
                print(cat)
            case .failure(let error):
                print(error)
            }
        }
    }
}



