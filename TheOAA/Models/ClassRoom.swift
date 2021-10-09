//
//  Class.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 07/10/2021.
//

import UIKit
import Firebase

class ClassRoom {
    var classname:String
    var introduction: String
    var classstaff: [String]
    var location: String
    var classpoint: Int
    var studentlist: [String]
    var teacherlist: [String]
    var grade: String
    
    init (SnapShot: QueryDocumentSnapshot) {
        self.classname = SnapShot["classname"] as! String
        self.introduction = SnapShot["introduction"] as! String
        self.classstaff = SnapShot["classstaff"] as! [String]
        self.location = SnapShot["location"] as! String
        self.classpoint = SnapShot["classpoint"] as! Int
        self.studentlist = SnapShot["studentlist"] as! [String]
        self.teacherlist = SnapShot["teacherlist"] as! [String]
        self.grade = SnapShot["grade"] as! String
    }
    
    init (DocSnapShot: DocumentSnapshot) {
        self.classname = DocSnapShot["classname"] as! String
        self.introduction = DocSnapShot["introduction"] as! String
        self.classstaff = DocSnapShot["classstaff"] as! [String]
        self.location = DocSnapShot["location"] as! String
        self.classpoint = DocSnapShot["classpoint"] as! Int
        self.studentlist = DocSnapShot["studentlist"] as! [String]
        self.teacherlist = DocSnapShot["teacherlist"] as! [String]
        self.grade = DocSnapShot["grade"] as! String
    }
}
