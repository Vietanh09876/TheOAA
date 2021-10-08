//
//  SubAchievement.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 06/10/2021.
//

import UIKit
import Firebase

class SubAchievement {
    var name: String
    var description: String
    var imageurl: String
    var id: String
    var reward: String
    
    init(SnapShot: QueryDocumentSnapshot) {
        self.name = SnapShot.data()["name"] as! String
        self.description = SnapShot.data()["description"] as! String
        self.imageurl = SnapShot.data()["imageurl"] as! String
        self.id = SnapShot.reference.documentID
        self.reward = SnapShot.data()["reward"] as! String
    }
}
