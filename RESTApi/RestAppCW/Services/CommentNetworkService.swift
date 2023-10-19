import Foundation
import SwiftyJSON
import Alamofire

class CommentNetworkService {
    static func getComments(postID: Int, callback: @escaping (_ result: [Comment]?, _ error: Error?) -> ()) {
        
        let urlPath = "\(ApiConstants.commentsPath)?postId=\(postID)"
        
        AF.request(urlPath, method: .get, encoding: JSONEncoding.default)
            .response { response in

                var value: [Comment]?
                var err: Error?

                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        callback(value, err)
                        return
                    }
                    print(JSON(data))
                    do {
                        value = try JSONDecoder().decode([Comment].self, from: data)
                    } catch (let decoderError) {
                        callback(value, decoderError)
                    }
                case .failure(let error):
                    err = error
                }
                callback(value, err)
            }
    }
}
