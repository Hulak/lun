//
//  DBManager.swift
//  lun
//
//  Created by Alyona Hulak on 2/19/19.
//  Copyright © 2019 Alyona Hulak. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    
    func storeModels(completion: @escaping () -> Void)
    {
        guard let url = Bundle.main.url(forResource: "AllData", withExtension: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: url)
            guard let user = try? JSONDecoder().decode(StoredUser.self, from: data) else {
                return
            }
            
            let realm = try Realm()
            print(realm.configuration.fileURL?.absoluteString ?? "")
           
            try! realm.write {
                realm.deleteAll()
                realm.add(user)
                completion()
            }
        } catch {
        }
    }
    
}
