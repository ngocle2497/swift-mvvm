import Foundation

class NewsFeed: Codable {
    var id: String
    var name: String
    var avatar: String
    var content: String
    var image: String?
    
    init(id: String, name: String, avatar: String, content: String, image: String?) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.content = content
        self.image = image
    }
}
