//
//  RealmModels.swift
//  lun
//
//  Created by Alyona Hulak on 2/19/19.
//  Copyright © 2019 Alyona Hulak. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class StoredUser: Object, Decodable {
    dynamic var person: StoredPerson? = StoredPerson()
    let images = RealmSwift.List<StoredImages>()
    
    enum CodingKeys: String, CodingKey {
        case person
        case images
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        person = try container.decode(StoredPerson.self, forKey: .person)
    
        let imagesList = try container.decode([StoredImages].self, forKey: .images)
        images.append(objectsIn: imagesList)
        
        super.init()
    }

    required init()
    {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema)
    {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema)
    {
        super.init(realm: realm, schema: schema)
    }
}

@objcMembers class StoredPerson: Object, Decodable {
    dynamic var person_id: Int = 0
    dynamic var name: String = ""
    dynamic var address: String = ""
    dynamic var phone: String = ""
    dynamic var profile_image_id: Int = 0
    dynamic var lat: Double = 0
    dynamic var lng: Double = 0
    
    override static func primaryKey() -> String? {
        return "person_id"
    }
    
    enum CodingKeys: String, CodingKey {
        case person_id
        case name
        case address
        case phone
        case profile_image_id
        case lat
        case lng

    }
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        person_id = try container.decode(Int.self, forKey: .person_id)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        phone = try container.decode(String.self, forKey: .phone)
        profile_image_id = try container.decode(Int.self, forKey: .profile_image_id)
        lat = try container.decode(Double.self, forKey: .lat)
        lng = try container.decode(Double.self, forKey: .lng)
        
        super.init()
    }
    
    required init()
    {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema)
    {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema)
    {
        super.init(realm: realm, schema: schema)
    }
}

@objcMembers class StoredImages: Object, Decodable {
    dynamic var image_id: Int = 0
    dynamic var link: String = ""
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        image_id = try container.decode(Int.self, forKey: .image_id)
        link = try container.decode(String.self, forKey: .link)
        
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "image_id"
    }
    
    enum CodingKeys: String, CodingKey {
        case image_id
        case link
    }
    
    required init()
    {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema)
    {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema)
    {
        super.init(realm: realm, schema: schema)
    }
}
