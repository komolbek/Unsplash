//
//  Created by Komolbek Ibragimov on 13/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit.UILabel

extension UILabel {
    
    func setupAttributedText(using text: String?) {
        let likeIcon = UIImage.MainFeed.likeLabelIcon
        
        let textAttachment = NSTextAttachment()
        textAttachment.image = likeIcon
        textAttachment.setHeight(of: 25)
        
        let attributedText = NSMutableAttributedString(string: text ?? "")
        let textAttachmentInAttributedString = NSAttributedString(attachment: textAttachment)
        attributedText.append(textAttachmentInAttributedString)
        
        self.attributedText = attributedText
    }
}
