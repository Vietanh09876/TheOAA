//
//  users.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 08/09/2021.
//

import UIKit

class Student {
    var name: String!
    var id: String!
    var schoolname: String!
    var classname: String!
    var classrole: String?
    var avatarimageurl: String!
    var useraccuid: String!
    
    var academicability: Float!
    var physicalability: Float!
    var adaptability: Float!
    var socialcontribution: Float!
    var reliability: Float!
    var previousscore: [Float]!
    
    var personalinfo: [String]!
    var guardianname: [String]!
    var guardianphonenumber: [String]!
    
    init(name:String, id:String, useraccuid: String ,classname:String, classrole: String?, academic: Float, physical:Float, adapt: Float, social: Float, reli: Float) {
        self.name = name
        self.id = id
        self.useraccuid = useraccuid
        self.classname = classname
        self.classrole = classrole
        self.academicability = academic
        self.adaptability = adapt
        self.physicalability = physical
        self.socialcontribution = social
        self.reliability = reli
    }
    
    init(name:String, id:String, avatarimageurl: String, schoolname: String ,classname:String, classrole:String?, academic: Float, physical:Float, adapt: Float, social: Float, reli: Float, previousscore: [Float]) {
        self.name = name
        self.id = id
        self.avatarimageurl = avatarimageurl
        self.schoolname = schoolname
        self.classname = classname
        self.classrole = classrole
        self.academicability = academic
        self.adaptability = adapt
        self.physicalability = physical
        self.socialcontribution = social
        self.reliability = reli
        self.previousscore = previousscore
    }
    
    init(personalinfo: [String], guardianname: [String], guardianphone: [String]) {
        self.personalinfo = personalinfo
        self.guardianname = guardianname
        self.guardianphonenumber = guardianphone
    }
    
    init (schoolname: String, classname: String, classrole: String) {
        self.schoolname = schoolname
        self.classname = classname
        self.classrole = classrole
    }
    
    
    func OverallScore() -> Float {
        let socialmultiplied = socialcontribution * 0.5
        return (academicability + adaptability + physicalability + socialmultiplied)/3.5
    }
}

