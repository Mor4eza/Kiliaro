//
//  ImageViewModel.swift
//  Kiliaro
//
//  Created by Morteza on 11/20/21.
//

import Foundation

class ImageViewModel {
        
    func fetchImages(_ complation: @escaping (Result<[ImageModel], Error>) -> Void) {
        let imageReq = ImagesRequest()
        Network().request(req: imageReq) { (result) in
            switch result {
                case .success(let images):
                    complation(.success(images))
                    
                case .failure(let error):
                    complation(.failure(error))
                    
            }
        }
    }
}
