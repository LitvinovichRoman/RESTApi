import Foundation
import SwiftyJSON
import Alamofire

class PostNetworkService {
    static func deletePost(postID: Int, callback: @escaping (_ result: JSON?, _ error: Error?) -> ()) {
        let urlPath = "\(ApiConstants.postsPath)/\(postID)"
        AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
            .response { response in

                var jsonValue: JSON?
                var err: Error?

                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        callback(jsonValue, err)
                        return
                    }
                    jsonValue = JSON(data)
                case .failure(let error):
                    err = error
                }
                callback(jsonValue, err)
            }
    }
}
