//
//  NewModel.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 2/27/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import Firebase
import MessageKit
import FirebaseFirestore

import Foundation
import CoreLocation
import MessageKit

private struct CoordinateItem: LocationItem {
    
    var location: CLLocation
    var size: CGSize
    
    init(location: CLLocation) {
        self.location = location
        self.size = CGSize(width: 240, height: 240)
    }
    
}

private struct ImageMediaItem: MediaItem {
    
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
    
    init(image: UIImage) {
        self.image = image
        self.size = CGSize(width: 240, height: 240)
        self.placeholderImage = UIImage()
    }
    
}

struct Message: MessageType {

var messageId: String
var sender: Sender
var sentDate: Date
var kind: MessageKind

private init(kind: MessageKind, sender: Sender, messageId: String, date: Date) {
    self.kind = kind
    self.sender = sender
    self.messageId = messageId
    self.sentDate = date
}

init(custom: Any?, sender: Sender, messageId: String, date: Date) {
    self.init(kind: .custom(custom), sender: sender, messageId: messageId, date: date)
}

init(text: String, sender: Sender, messageId: String, date: Date) {
    self.init(kind: .text(text), sender: sender, messageId: messageId, date: date)
}

init(attributedText: NSAttributedString, sender: Sender, messageId: String, date: Date) {
    self.init(kind: .attributedText(attributedText), sender: sender, messageId: messageId, date: date)
}

init(image: UIImage, sender: Sender, messageId: String, date: Date) {
    let mediaItem = ImageMediaItem(image: image)
    self.init(kind: .photo(mediaItem), sender: sender, messageId: messageId, date: date)
}

init(thumbnail: UIImage, sender: Sender, messageId: String, date: Date) {
    let mediaItem = ImageMediaItem(image: thumbnail)
    self.init(kind: .video(mediaItem), sender: sender, messageId: messageId, date: date)
}

init(location: CLLocation, sender: Sender, messageId: String, date: Date) {
    let locationItem = CoordinateItem(location: location)
    self.init(kind: .location(locationItem), sender: sender, messageId: messageId, date: date)
}

init(emoji: String, sender: Sender, messageId: String, date: Date) {
    self.init(kind: .emoji(emoji), sender: sender, messageId: messageId, date: date)
}

}


