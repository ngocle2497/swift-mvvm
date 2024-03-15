//
//  ItemCollectionViewCell.swift
//  MVVM
//
//  Created by Ngoc H. Le on 15/03/2024.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: BRemoteImage!
    override func awakeFromNib() {
        super.awakeFromNib()
        setData()
    }
    
    func setData() {
        imageView.placeholderHash = .blurhash("LnGIZJS$bws._4f+kXof.9afkDWq")
        imageView.source = "https://fastly.picsum.photos/id/905/200/300.jpg?hmac=uLUlIwyKcu9AtTY3uOL04O0gbesMVu-yNVRvCsF1xD8"
       
    }

}
