//
//  Created by Kamolbek on 20/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

final class RegistrationViewModel {
    
    let cellModels: [RegistrationCellModel]
    
    init(state: RegistrationState) {        
        cellModels = RegistrationField.allCases.enumerated().compactMap { (index, value) -> RegistrationCellModel? in
            var error: String?
            var text: String?
            
            if let _ = state.errors.keys.firstIndex(of: IndexPath(row: index, section: 0)) {
                error = state.errors[IndexPath(row: index, section: 0)]
            }
            
            if let _ = state.texts.keys.firstIndex(of: IndexPath(row: index, section: 0)) {
                text = state.texts[IndexPath(row: index, section: 0)]
            }
            
            return RegistrationCellModel(title: value.title,
                                         text: text,
                                         error: error ?? "")
        }
    }
}

// MARK: -  Equatable

extension RegistrationViewModel: Equatable {
    
    static func == (lhs: RegistrationViewModel, rhs: RegistrationViewModel) -> Bool {
        return lhs.cellModels == rhs.cellModels
    }
}
