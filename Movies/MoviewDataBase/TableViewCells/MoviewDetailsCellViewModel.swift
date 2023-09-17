//
//  MoviewDetailsCellViewModel.swift
//  Movies
//
//  Created by Softsuave on 16/09/2023.
//

import Foundation

class MoviewDetailsCellViewModel {
    var imageData: ObservableObject<Data?> = ObservableObject(nil)
    
    func getImageData(url:String) {
        NetworkManager.getNetworkManagerInstance.downloadImage(url) { image, urlString in
            if let data = image {
                self.imageData.value = data
            }
        }
    }
}
