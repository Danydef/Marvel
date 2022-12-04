//
//  UIImageView+extension.swift
//  RickAndMorty
//
//  Created by Daniel Personal on 3/12/22.
//

import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil || response == nil {
                return
            }
                        
            DispatchQueue.main.async {
                guard let data else {
                    return
                }
                let image = UIImage(data: data)
                self.image = image
            }
            
        }).resume()
    }
}
