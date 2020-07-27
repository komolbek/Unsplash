//  Created by Kamolbek on 08/07/2020
//  Copyright © 2020 HiQo. All rights reserved.

final class PhotoService: NetworkService, PhotoServiceProtocol {
    
    func fetchPhotos(success: @escaping ([FeedImage]?) -> Void,
                     failure: @escaping (Error) -> Void) {
        
        let endpoint: PhotoEndpoint = .new
        request(endpoint: endpoint, success: { (response: [FeedImage]) in
            success(response)
        }, failure: { (error) in
            failure(error)
        })
    }
    
    func fetchCategories(success: @escaping ([FeedCategory]?) -> Void,
                          failure: @escaping (Error) -> Void) {
        
        let endpoint: PhotoEndpoint = .collections
        
        request(endpoint: endpoint, success: { (response: [FeedCategory]) in
            success(response)
        }, failure: { (error) in
            failure(error)
        })
    }
    
    func fetchCategoryDetails(title: String?,
                              categoryID: Int?,
                              success: @escaping (CategoryDetails?) -> Void,
                              failure: @escaping (Error) -> Void) {
        
        let endpoint: PhotoEndpoint = .categotyDetails(title: title, categoryID: categoryID)
        
        request(endpoint: endpoint, success: { (response: CategoryDetails) in
            success(response)
        }, failure: { (error) in
            failure(error)
        })
    }
}
