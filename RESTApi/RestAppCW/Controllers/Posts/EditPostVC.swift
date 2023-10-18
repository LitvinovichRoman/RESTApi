
import UIKit
import Alamofire
import SwiftyJSON

class EditPostVC: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var bodyTV: UITextView!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyTV.roundElement()
    }
    
    @IBAction func post() {
        if let userId = user?.id,
           let title = titleTF.text,
           let body = bodyTV.text,
           let url = ApiConstants.postsURL {
            
            let parameters: Parameters = [
                "userId": userId,
                "title": title,
                "body": body
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .response { [weak self] response in

                    debugPrint(response)
                    print(response.request)
                    print(response.response)
                    debugPrint(response.result)
                    
                    switch response.result {
                    case .success(let data):
                        print(data)
                        print(JSON(data))
                        self?.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print(error)
                        
                    }
                }
        }
    }

}
