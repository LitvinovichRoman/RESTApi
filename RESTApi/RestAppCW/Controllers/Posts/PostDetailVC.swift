import UIKit

class PostDetailVC: UIViewController {
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var contentBody: UILabel!
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userData(post: post)
    }
    
    @IBAction func editPostBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "EditPostVC") as! EditPostVC
        vc.post = post
        navigationController?.present(vc, animated: true)
    }
    
    
    
    private func userData(post: Post?) {
        if let post = post {
            postTitle.text = post.title
            contentBody.text = post.body
        } else {
            postTitle.text = "Error"
            contentBody.text = "Error"
        }
    }
}
