import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class NetworkService {
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
    
    static func deletePhoto(photoID: Int, callback: @escaping (_ result: JSON?, _ error: Error?) -> ()) {
        
        let urlPath = "\(ApiConstants.photosPath)/\(photoID)"
        
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
    
    static func deleteUser(userId: Int, callback: @escaping () -> ()) {
        let urlPath = "\(ApiConstants.usersPath)/\(userId)"
        AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
            .response { response in
                callback()
            }
    }
    
    
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
    
    static func getThumbnail(thumbnailURL: String, callback: @escaping (_ result: UIImage?, _ error: AFError?) -> ()) {
        AF.request(thumbnailURL).responseImage { response in
            switch response.result {
                case .success(let image): callback(image, nil)
                case .failure(let error): callback(nil, error)
            }
        }
    }
    
    static func getData(from url: URL, complition: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: complition).resume()
    }
    
    static func downloadImage(from url: URL, callback: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        getData(from: url) { data, response, error in
            if let data,
               let image = UIImage(data: data) {
                callback(image, nil)
            } else {
                callback(nil, error)
            }
        }
    }
    
}
