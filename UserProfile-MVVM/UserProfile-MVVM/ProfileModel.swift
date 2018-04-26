//
//  ProfileModel.swift
//  UserProfile-MVVM
//
//  Created by Karamjeet Singh on 26/04/18.
//  Copyright © 2018 TheSimpleApps@gmail.com. All rights reserved.
//

import Foundation

// Get Json data
public func dataFromFile(_ filename: String) -> Data? {
    
    @objc class TestClass: NSObject { }
    let bundle = Bundle(for : TestClass.self)
    if let path = bundle.path(forResource: filename, ofType: "json") {
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    
    return nil
}


class Profile {
    
    var fullName: String?
    var pictureUrl: String?
    var email: String?
    var about: String?
    var friends = [Friend]()
    var profileAttributes = [Attribute]()
    
    init?( data: Data ) {
        do {
            
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let body = json["data"] as? [String: Any] {
            
                self.fullName = body["fullName"] as? String
                self.pictureUrl = body["pictureUrl"] as? String
                self.about = body["about"] as? String
                self.email = body["email"] as? String
                
                if let frinds = body["friends"] as? [[String: Any]] {
                    self.friends = frinds.map { Friend(json: $0) }
                }
                
                if let attributes = body["profileAttributes"] as? [[String: Any]] {
                    self.profileAttributes = attributes.map { Attribute(json: $0) }
                }
                
                
            }
        } catch {
            print("Error deserializing JSON: \(error)")
            return nil
        }
    }
}

class Friend {
    var name: String?
    var pictureUrl: String?
    
    init(json: [String: Any]) {
        self.name = json["fullName"] as? String
        self.pictureUrl = json["pictureUrl"] as? String
    }
    
}

class Attribute {
    var key: String?
    var value: String?

    init(json: [String: Any]) {
        self.key = json["key"] as? String
        self.value = json["value"] as? String
    }

}


//public func dataFromFile(_ filename: String) -> Data? {
//    @objc class TestClass: NSObject { }
//
//    let bundle = Bundle(for: TestClass.self)
//    if let path = bundle.path(forResource: filename, ofType: "json") {
//        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
//    }
//    return nil
//}
//
//class Profile {
//    var fullName: String?
//    var pictureUrl: String?
//    var email: String?
//    var about: String?
//    var friends = [Friend]()
//    var profileAttributes = [Attribute]()
//
//    init?(data: Data) {
//        do {
//            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let body = json["data"] as? [String: Any] {
//                self.fullName = body["fullName"] as? String
//                self.pictureUrl = body["pictureUrl"] as? String
//                self.about = body["about"] as? String
//                self.email = body["email"] as? String
//
//                if let friends = body["friends"] as? [[String: Any]] {
//                    self.friends = friends.map { Friend(json: $0) }
//                }
//
//                if let profileAttributes = body["profileAttributes"] as? [[String: Any]] {
//                    self.profileAttributes = profileAttributes.map { Attribute(json: $0) }
//                }
//            }
//        } catch {
//            print("Error deserializing JSON: \(error)")
//            return nil
//        }
//    }
//}
//
//class Friend {
//    var name: String?
//    var pictureUrl: String?
//
//    init(json: [String: Any]) {
//        self.name = json["name"] as? String
//        self.pictureUrl = json["pictureUrl"] as? String
//    }
//}
//
//class Attribute {
//    var key: String?
//    var value: String?
//
//    init(json: [String: Any]) {
//        self.key = json["key"] as? String
//        self.value = json["value"] as? String
//    }
//}
