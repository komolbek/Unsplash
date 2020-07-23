import Foundation

struct FeedImage: Codable {
    
    let createdAt: String?
    let width: Int?
    let height: Int?
    let urls: PhotoUrl?
    let likes: Int?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case width, height
        case urls,likes
        case user
    }
}


