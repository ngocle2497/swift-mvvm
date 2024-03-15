import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var homeViewModel: HomeViewModel = HomeViewModel()
    var longPressedEnabled = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        collectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController!.viewControllers.count > 1
    }
    
    func update() {
        print("Home Updating")
    }
    
}

extension HomeViewController: UICollectionViewDelegate,
                              UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeViewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        cell.setData(cellData: homeViewModel.data[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (UIScreen.main.bounds.size.width) - 16
        
        let cellData = homeViewModel.data[indexPath.row]
        let avatarSize = 50.0
        let imageHeight = cellData.image != nil ? 200 : 0
        let contentHeight = heightForLable(text: cellData.content, font: .title2Regular, width: width)
        let contentSpacing = imageHeight == 0 ? 12.0 : 24.0
        
        return CGSize(width: width, height: Double(imageHeight) + contentHeight + avatarSize + contentSpacing)
    }
    
    func heightForLable(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        // pass string, font, LableWidth
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
         label.numberOfLines = 0
         label.lineBreakMode = NSLineBreakMode.byWordWrapping
         label.font = font
         label.text = text
         label.sizeToFit()

         return label.frame.height
    }
}

