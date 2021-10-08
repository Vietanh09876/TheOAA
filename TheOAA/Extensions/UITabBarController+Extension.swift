//
//  UITabBarController+Extension.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 15/09/2021.
//


import UIKit
import Firebase


let db = Firestore.firestore()
var reloadednumberoftimes: Int = 0


extension UITabBarController {
    func MyCustomMainTabBar() -> UITabBarController {
        let tabBC = UITabBarController()
        
        let newsboardVC = NewsBoardViewController()
        let classlistVC = ClassListViewController()
        let grouplistVC = GroupListViewController()
        let tasklistVC = TaskListViewController()
        
        newsboardVC.tabBarItem = UITabBarItem(title: " ", image: UIImage(named: "ic_news")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "ic_newsSelect")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        
        classlistVC.tabBarItem = UITabBarItem(title: " ", image: UIImage(named: "ic_class")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "ic_classSelect")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        
        grouplistVC.tabBarItem = UITabBarItem(title: " ", image: UIImage(named: "ic_group")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "ic_groupSelect")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        
        tasklistVC.tabBarItem = UITabBarItem(title: " ", image: UIImage(named: "ic_task")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "ic_taskSelect")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        
        tabBC.tabBar.tintColor = .clear
        tabBC.tabBar.barTintColor = UIColor(red: 0.61, green: 0.78, blue: 0.55, alpha: 1.00)
        tabBC.tabBar.isTranslucent = false
        
        fetchDataForClassVC(classlistVC: classlistVC)
        
        tabBC.setViewControllers([newsboardVC, classlistVC, grouplistVC, tasklistVC], animated: true)
        return tabBC
    }
    
    //MARK: - FetchDataForClasslistVC
    func fetchDataForClassVC(classlistVC: ClassListViewController) {
        let userAccId = Auth.auth().currentUser!.uid
        let userFirestoreDoc = db.collection("users").document(userAccId)
        
        userFirestoreDoc.getDocument { document, error in
            guard let document = document else {
                if reloadednumberoftimes <= 5 {
                    self.fetchDataForClassVC(classlistVC: classlistVC)
                }
                else {
                    return
                }
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            let schoolname = data["schoolname"] as! String
            let classname = data["classname"] as! String
            let classrole = data["classrole"] as! String
            let grade = data["grade"] as! String
            
            classlistVC.user = Student(schoolname: schoolname, classname: classname, classrole: classrole)
            
            self.fetchDataForGrade(schoolname: schoolname, classlistVC: classlistVC)
            self.fetchDataForUserClass(schoolname: schoolname, grade: grade, classname: classname, classlistVC: classlistVC)
        }
    }
    
    func fetchDataForGrade(schoolname: String, classlistVC: ClassListViewController) {
        let schoolgradecollection = db.collection(schoolname)
        schoolgradecollection.getDocuments { collection, error in
            guard let collection = collection, error == nil else {
                return
            }
            classlistVC.gradesarray = ["Lớp Của Tôi"]
            for val in collection.documents {
                classlistVC.gradesarray.append(val["name"] as! String)
                self.fetchDataForClasslist(schoolname: schoolname, grade: val.documentID, classlistVC: classlistVC)
            }
        }
    }
    
    func fetchDataForClasslist(schoolname: String, grade: String, classlistVC: ClassListViewController) {
        let gradeclasslistRef = db.collection(schoolname).document(grade).collection("ClassList")
        var classes = [ClassRoom]()
        
        gradeclasslistRef.getDocuments { collection, error in
            guard let collection = collection, error == nil else {
                return
            }
            for val in collection.documents {
                classes.append(ClassRoom(SnapShot: val))
            }
            classlistVC.classarray.append(classes)
        }
    }
    
    func fetchDataForUserClass(schoolname: String, grade: String, classname: String ,classlistVC: ClassListViewController) {
        let classRef = db.collection(schoolname).document(grade).collection("ClassList").document(classname)

        classRef.addSnapshotListener { document, error in
            guard let document = document, error == nil else {
                return
            }
            classlistVC.userclassrom = ClassRoom(DocSnapShot: document)
        }
    }
}
