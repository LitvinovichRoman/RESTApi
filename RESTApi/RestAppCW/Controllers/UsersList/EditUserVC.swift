
import UIKit
import Alamofire

class EditUserVC: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surNameTextField: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var websiteTF: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var adressTF: UITextField!
    var user: User?
    
    @IBAction func doneBtnAction(_ sender: UIButton) {
        if let userId1 = user?.id,
           let nameTextField = nameTextField.text,
           let surNameTextField = surNameTextField.text,
           let email = emailTF.text,
           let phone = phoneTF.text,
           let website = websiteTF.text,
           let adress = adressTF.text,
           
            let url = ApiConstants.usersURL {
            
            let parameters: Parameters = [
                "userId": userId1,
                "name": nameTextField,
                "username": surNameTextField,
                "email": email,
                "phone": phone,
                "website": website,
                "adress": adress
            ]
            
            AF.request("\(url)/\(userId1)", method: .patch, parameters: parameters, encoding: JSONEncoding.default)
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
