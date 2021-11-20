//
//  ImagesRequest.swift
//  Kiliaro
//
//  Created by Morteza on 11/20/21.
//

import Foundation

class ImagesRequest: Requestable {
    typealias ResponseType = [ImageModel]
    
    var path: String {
        let sharedID = "djlCbGusTJamg_ca4axEVw"
        return "/shared/\(sharedID)/media"
    }
    
}
