//
//  MoviewDetailsViewModel.swift
//  Movies
//
//  Created by Softsuave on 17/09/2023.
//

import Foundation

class MoviewDetailsViewModel {
    //MARK: - Variables
    var imageData: ObservableObject<Data?> = ObservableObject(nil)
    
    //MARK: - Converting url to image data
    func getImageData(url:String) {
        NetworkManager.getNetworkManagerInstance.downloadImage(url) { image, urlString in
            if let data = image {
                self.imageData.value = data
            }
        }
    }
}
