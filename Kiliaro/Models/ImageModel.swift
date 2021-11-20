//
//  ImageModel.swift
//  Kiliaro
//
//  Created by Morteza on 11/20/21.
//

import Foundation
class ImageModel: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case `id` = "id"
        case `type` = "media_type"
        case `name` = "filename"
        case `size` = "size"
        case `created_at` = "created_at"
        case `taken_at` = "taken_at"
        case `thumbnailUrl` = "thumbnail_url"
        case `downloadUrl` = "download_url"
        case `res_x` = "resx"
        case `res_y` = "resy"
    }
    
    let id: String
    let type: String
    let name: String
    let size: Int64
    let created_at: String
    let taken_at: String?
    let thumbnailUrl: String
    let downloadUrl: String
    let res_x: Float
    let res_y: Float
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decode(String.self, forKey: .type)
        self.name = try container.decode(String.self, forKey: .name)
        self.size = try container.decode(Int64.self, forKey: .size)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.taken_at = try? container.decode(String.self, forKey: .taken_at)
        self.thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
        self.downloadUrl = try container.decode(String.self, forKey: .downloadUrl)
        self.res_x = try container.decode(Float.self, forKey: .res_x)
        self.res_y = try container.decode(Float.self, forKey: .res_y)
    }
}
