//
//  Created by Komolbek Ibragimov on 21/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

final class RegistrationCellModel {
    
    let title: String
    let text: String?
    let error: String?
    
    init(title: String, text: String?, error: String?) {
        self.title = title
        self.text = text
        self.error = error
    }
}

extension RegistrationCellModel: Equatable {
    
    static func == (lhs: RegistrationCellModel, rhs: RegistrationCellModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.text == rhs.text &&
            lhs.error == rhs.error
    }
}
