import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageContent: BRemoteImage!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: BRemoteImage!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        content.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        
        name.font = .title2Bold
        name.textColor = .primaryContent
        content.font = .title2Regular
        content.textColor = .secondaryContent
    }
    
    func setData(cellData: NewsFeed) {
        name.text = cellData.name
        content.text = cellData.content
        avatar.placeholderHash = .blurhash("LKN]Rv%2Tw=w]~RBVZRi};RPxuwH")
        avatar.source = cellData.avatar
        if let imageUrl = cellData.image {
            imageContent.topAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
            imageContent.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
            
            imageContent.source = imageUrl
            imageContent.isHidden = false
        } else {
            imageContent.isHidden = true
            content.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        }
    }
}
