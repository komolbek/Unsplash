//
//  Created by Kamolbek on 13/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

final class CategoryDetailViewModel {
    
    let cellModels: [FeedNewCellModel]?
    let isLoading: Bool
    let navigationTitle: String
    let navigationSubTitle: String

    init(state: CategoryDetailState) {
        self.navigationTitle = state.category.title ?? ""
        self.navigationSubTitle = "Curated by \(state.category.user?.name ?? "")"
        self.isLoading = state.isLoading
        
        self.cellModels = state.images?.compactMap { (images) -> FeedNewCellModel in
            
            let firstName: String = images.user?.firstName ?? ""
            let imageURL: URL? = URL(string: images.urls?.regular ?? "")
            let createdAt: String = String(images.createdAt?.stringToDate()?.timeSinceDate(fromDate: Date.currentDate()) ?? "")
            let width: CGFloat = CGFloat(images.width ?? 0)
            let height: CGFloat = CGFloat(images.height ?? 0)
            let likes: String = String(describing: images.likes ?? 0)
            
            return FeedNewCellModel(userName: firstName,
                                    date: createdAt,
                                    imageURL: imageURL,
                                    width: width,
                                    height: height,
                                    likes: likes)
        }
    }
}

// MARK: -  Equatable

extension CategoryDetailViewModel: Equatable {
    
     static func == (lhs: CategoryDetailViewModel, rhs: CategoryDetailViewModel) -> Bool {
        return false
    }
}
