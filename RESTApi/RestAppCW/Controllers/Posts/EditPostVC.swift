import UIKit
import SwiftyJSON
import Alamofire

class EditPostVC: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var contentTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTV.roundElement()
    }
    var post: Post?
    
    @IBAction func doneBtnAction(_ sender: UIButton) {
        if let postId = post?.id,
           let titleTF = titleTF.text,
           let contentTV = contentTV.text,
           
            let url = ApiConstants.postsURL {
            
            let parameters: Parameters = [
                "title": titleTF,
                "body": contentTV,
            ]
            
            AF.request("\(url)/\(postId)", method: .patch, parameters: parameters, encoding: JSONEncoding.default)
                .response { [weak self] response in
                    switch response.result {
                    case .success:
                        self?.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print(error)
                    }
                }
        }
    }
}

