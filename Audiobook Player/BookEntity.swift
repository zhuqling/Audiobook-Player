//
//  Book.swift
//  Audiobook Player
//
//  Created by Bryan Rezende on 11/2/17.
//  Copyright © 2017 Tortuga Power. All rights reserved.
//

import Foundation
import RealmSwift

class BookEntity: Object {
    // MARK: - Identifying properties
    @objc dynamic var title: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var uuid = UUID().uuidString
    @objc dynamic var coverArtPath: String?
    
    @objc dynamic var isbn: String?
    @objc dynamic var goodreadsId: String?
    
    @objc dynamic var rating: Int = 0
    
    // MARK: - Usage properties
    @objc dynamic var lengthSeconds: Int = 0
    @objc dynamic var positionSeconds: Int = 0
    
    @objc dynamic var startTimestamp: Date?
    @objc dynamic var finishTimestamp: Date?
    
    let fileList = List<String>()
    
    // MARK: - Init
    convenience init(title: String, author: String) {
        self.init()
        
        self.title = title
        self.author = author
    }
    
    // MARK: - Dynamic Properties
    func isFinished() -> Bool {
        return finishTimestamp != nil
    }
    
    // MARK: - Meta
    override class func primaryKey() -> String? {
        return "uuid"
    }
}
