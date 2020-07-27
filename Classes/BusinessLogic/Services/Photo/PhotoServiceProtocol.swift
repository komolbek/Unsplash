//
//  Created by Kamolbek on 08/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

protocol HasPhotoService {
    var photoService: PhotoServiceProtocol { get }
}

protocol PhotoServiceProtocol: class {
    func fetchPhotos(success: @escaping ([FeedImage]?) -> Void,
                     failure: @escaping (Error) -> Void)
    
    func fetchCategories(success: @escaping ([FeedCategory]?) -> Void,
                         failure: @escaping (Error) -> Void)
    
    func fetchCategoryDetails(title: String?,
                              categoryID: Int?,
                              success: @escaping (CategoryDetails?) -> Void,
                              failure: @escaping (Error) -> Void)
}
