import Foundation
import Alamofire
import UIKit

class ThumbnailNetworkService {
    static func getThumbnail(thumbnailURL: String, callback: @escaping (_ result: UIImage?, _ error: AFError?) -> ()) {
        AF.request(thumbnailURL).responseImage { response in
            switch response.result {
                case .success(let image): callback(image, nil)
                case .failure(let error): callback(nil, error)
            }
        }
    }
}
