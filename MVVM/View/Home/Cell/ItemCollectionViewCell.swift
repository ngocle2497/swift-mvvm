//
//  ItemCollectionViewCell.swift
//  MVVM
//
//  Created by Ngoc H. Le on 15/03/2024.
//

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
        dump(name.font)
//        name.font = UIFont(name: ".SFUI-Regular", size: 18)
//        name.textColor = .primaryContent
//
        content.font = .title2Regular
        dump(content.font)
//        content.textColor = .primaryContent
    }
    
    func setData(cellData: NewsFeed) {
        name.text = cellData.name
        content.text = cellData.content
        avatar.placeholderHash = .blurhash("LKN]Rv%2Tw=w]~RBVZRi};RPxuwH")
        avatar.source = cellData.avatar
        if let imageUrl = cellData.image {
            imageContent.source = imageUrl
            imageContent.isHidden = false
        } else {
            imageContent.isHidden = true
        }
    }

}
