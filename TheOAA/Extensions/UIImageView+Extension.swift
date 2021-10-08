//
//  UIImageView+Extension.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 07/10/2021.
//

import UIKit
import ProgressHUD

let imagecache = NSCache<NSString, AnyObject>()
var OldUrlstring: String = "??"

extension UIImageView {
    func loadImageFromCacheWithUrlstring(urlstring: String) {
        
        if let cachedimage = imagecache.object(forKey: urlstring as NSString) as? UIImage, urlstring == OldUrlstring {
            self.image = cachedimage
            print("take from cache")
        }
        else {
            ProgressHUD.show()
            DispatchQueue.global().async {
                guard let photourl = URL(string: urlstring) ,let data = try? Data.init(contentsOf: photourl)  else {
                    ProgressHUD.dismiss()
                    return
                }
                let downloadedimage = UIImage.init(data: data)
                imagecache.removeObject(forKey: OldUrlstring as NSString)
                OldUrlstring = urlstring
                imagecache.setObject(downloadedimage!, forKey: urlstring as NSString)
                DispatchQueue.main.async {
                    self.image = downloadedimage
                }
                ProgressHUD.dismiss()
                print("download new")
            }
        }
    }
}

