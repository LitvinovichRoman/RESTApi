import Foundation
import Alamofire

class UserNetworkService {
    static func deleteUser(userId: Int, callback: @escaping () -> ()) {
           let urlPath = "\(ApiConstants.usersPath)/\(userId)"
            AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
            .response { response in
                callback()
        }
    }
}
