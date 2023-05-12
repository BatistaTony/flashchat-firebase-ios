//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Batista Tone on 09/05/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import Foundation


struct Constants {
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCellTableViewCell"
    static let registerToChat = "RegisterToChat"
    static let loginToChat = "LoginToChat"
    static let appName = "⚡️FlashChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
