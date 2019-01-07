//
//  Book.swift
//  bookSearch2
//
//  Created by Vicente Ordoñez Garcia on 1/6/19.
//  Copyright © 2019 Vicente Ordoñez Garcia. All rights reserved.
//

import Foundation

struct EbookResult : Decodable {
    //let ISBN : String
    let book : Book
    //let title : String
}

struct Book : Decodable {
    let title : String
    //let authors : [Author]
    //let cover : Cover
    //let url : String
    //let pagination : String
    //let notes: String
    //let number_of_pages : String
    //let publish_date : String
    //let key : String
    //let by_statement : String
    //let publishers : [Publishers]
    //let classifications : Classifications
    //let subjects : [Subjects]
    //let publish_places : [Publish_places]
    //let ebooks : [Ebooks]
}

struct Author : Decodable {
    let url : String
    let name : String
}


struct Cover : Decodable {
    let small : String
    let large : String
    let medium : String
}

struct Publishers : Codable {
    let name: String
}

struct Identifiers : Codable {
    let lccn : [String]
    let openlibrary : [String]
    let isbn_10 : [String]
    let librarything : [String]
    let goodreads : [String]
}


struct Classifications : Codable {
    let dewey_decimal_class : [String]
    let lc_classifications : [String]
}

struct Subjects : Codable {
    let url : String
    let name : String
}

struct Publish_places : Codable {
    let name : String
}

struct Ebooks : Codable {
    let checkout : Bool
    let formats : [String]
    let preview_url : String
    let borrow_url : [String]
    let abailability : String
}
