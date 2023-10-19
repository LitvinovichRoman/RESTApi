import Foundation
import Alamofire

class AlbomNetworkService {
    static func getAlboms(userID: Int, callback: @escaping (_ result: [Albom]?, _ error: Error?) -> ()) {
        
        let urlPath = "\(ApiConstants.albomsPath)?userId=\(userID)"
        AF.request(urlPath, method: .get, encoding: JSONEncoding.default)
            .response { response in

                var value: [Albom]?
                var err: Error?

                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        callback(value, err)
                        return
                    }
                    do {
                        value = try JSONDecoder().decode([Albom].self, from: data)
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
