//
//  RealmManager.swift
//  Audiobook Player
//
//  Created by Bryan Rezende on 11/4/17.
//  Copyright © 2017 Tortuga Power. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import RealmSwift


class RealmManger {
    static let realm = try! Realm()
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // Iterate through files and check for existing book
    class func addBooksToRealm(){
        DataManager.loadBooks { (booksArray) in
            for book in booksArray {
                if self.bookExistsInRealm(title: book.title, author: book.author) == nil {
                    try! self.realm.write {
                        self.realm.add(self.generateNewBookEntity(book: book))
                    }
                }
            }
        }
    }
    
    class func bookExistsInRealm(title: String, author: String) -> BookEntity?{
        let predicate = NSPredicate(format: "title = %@ && author = %@", title, author)
        let object = self.realm.objects(BookEntity.self).filter(predicate).first
        if object?.title == title {
            return object
        }
        return nil
    }
    
    class func generateNewBookEntity(book: Book) -> BookEntity {
        let realmBook = BookEntity(title: book.title, author: book.author)
        
        // Save image to disk, then load path as string to Realm to keep database access as light as possible
        if let data = UIImagePNGRepresentation(book.artwork) {
            let coverURL = getDocumentsDirectory().appendingPathComponent("\(realmBook.uuid).png")
            try? data.write(to: coverURL)
            realmBook.coverArtPath = coverURL.absoluteString
        }
        return realmBook
    }
}
