import UIKit

class HomeViewController: UIViewController,UIGestureRecognizerDelegate, GlobalUpdating {
    
    @Global var userSettings: UserSettings
    
    var collectionView: UICollectionView?
    let cellID = "CELL_ID"
    var arrIndexPath = [IndexPath]()
    
    var longPressedEnabled = false
    var data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,1, 2, 3, 4, 5, 6, 7, 8, 9, 10,1, 2, 3, 4, 5, 6, 7, 8, 9, 10,1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerUpdates()
        
    
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false;
        view.addSubview(collectionView!)
        
        collectionView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionView?.setCollectionViewLayout(collectionViewLayout, animated: true)
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.minimumInteritemSpacing = 10
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        //        collectionView?.dragDelegate = self
        //        collectionView?.dropDelegate = self
        
        // Do any additional setup after loading the view.
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(onLongPress))
        collectionView?.addGestureRecognizer(gesture)
    }
    func update() {
        print("Home Updating")
    }
    
    @objc func onLongPress(_ gesture: UILongPressGestureRecognizer) {
        userSettings.isAuthenticated.toggle();
//        guard let collectionView = collectionView else {
//            return
//        }
//        switch gesture.state {
//        case .began:
//            guard let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
//                return
//            }
//            longPressedEnabled = true
//            collectionView.beginInteractiveMovementForItem(at: indexPath)
//        case .changed:
//            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
//
//        case .ended:
//            longPressedEnabled = false
//            collectionView.endInteractiveMovement()
//        default:
//            collectionView.cancelInteractiveMovement()
//            longPressedEnabled = false
//        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate,
                              UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if arrIndexPath.contains(indexPath) == false {
            cell.transform = CGAffineTransform(translationX: 0, y: 20)
            cell.alpha = 0
            UIView.animate(withDuration: 0.5, delay: Double(indexPath.row) * 0.01) {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }
            arrIndexPath.append(indexPath)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 10 * 4) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = data.remove(at: sourceIndexPath.row)
        data.insert(item, at: destinationIndexPath.row)
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
