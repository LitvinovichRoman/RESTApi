import Foundation
import Alamofire

class PhotoNetworkService {
    static func getPhotos(albomID: Int, callback: @escaping (_ result: [Photo]?, _ error: Error?) -> ()) {
        
        let urlPath = "\(ApiConstants.photosPath)?albomId=\(albomID)"
        AF.request(urlPath, method: .get, encoding: JSONEncoding.default)
            .response { response in

                var value: [Photo]?
                var err: Error?

                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        callback(value, err)
                        return
                    }
                    do {
                        value = try JSONDecoder().decode([Photo].self, from: data)
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
