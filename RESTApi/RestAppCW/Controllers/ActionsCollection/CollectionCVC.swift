import UIKit
import Lottie

enum UserActions: String, CaseIterable {
    case downloadImage = "Download image"
    case users = "Open users list"
}

class CollectionCVC: UICollectionViewController {
    
    private let reuseIdentifier = "Cell"
    private let userActions = UserActions.allCases
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ActionCVCell
        let userAction = userActions[indexPath.row].rawValue
        
        cell.infiLbl.text = userAction
        cell.roundElementIntHeight()
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.row]
        
        switch userAction {
            
        case .downloadImage:
            showAnimation { self.performSegue(withIdentifier: "goToImageVC", sender: nil) }
            
        case .users:
            showAnimation { self.performSegue(withIdentifier: "openUsersList", sender: nil) }
            
        }
    }
    
    private func showAnimation(completion: @escaping () -> Void) {
        let animationView = LottieAnimationView(name:"activity")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1.5
        animationView.backgroundColor = .black
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.center = view.center
        view.addSubview(animationView)
        
        // Ставим задержку и предотвращаем блок главного потока 
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            animationView.play { _ in
                completion()
                animationView.removeFromSuperview()
            }
        }
    }
}
    
  
