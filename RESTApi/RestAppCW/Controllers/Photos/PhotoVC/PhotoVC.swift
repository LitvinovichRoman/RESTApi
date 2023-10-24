import UIKit

class PhotoVC: UIViewController {
    
    var photo: Photo?
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.style = .large
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getPhoto()
    }
    
    private func getPhoto() {
        guard let photo,
              let imagePath = photo.url,
              let url = URL(string: imagePath) else { return  }
        NetworkService.downloadImage(from: url) { [weak self] image, error in
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .darkGray
        view.addSubview(imageView)
        imageView.addSubview(activityIndicatorView)
        setupLayoutAnhors()
    }
    
    private func setupLayoutAnhors() {
        let margins = view.layoutMarginsGuide
        
        imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
    }
    
}
