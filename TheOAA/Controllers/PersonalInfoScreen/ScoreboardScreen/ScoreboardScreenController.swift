//
//  ScoreboardScreenController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 16/09/2021.
//

import UIKit


class ScoreboardScreenController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var CustomSegmentControl: CustomSegmentControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scoreboardImageView: UIImageView!
    
    //MARK: - Variable
    var scoreboardimageurl: [String]!
    let cache = NSCache<NSString, AnyObject>()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfig()
        
        CustomSegmentControl.pressedbuttonindex = {[weak self] x in
            
            self?.changescoreboardimage(x: x)
            
        }
        
        CustomSegmentControl.buttonDidTap(CustomSegmentControl.firstButton)
        
    }

    private func viewConfig() {
        self.view.backgroundColor = .clear
        
        CustomSegmentControl.backgroundColor = .clear
        CustomSegmentControl.firstButton.setTitle("Học Kỳ I", for: .normal)
        CustomSegmentControl.firstButton.setTitleColor(.white, for: .normal)
        
        CustomSegmentControl.seccondButton.setTitle("Học Kỳ II", for: .normal)
        CustomSegmentControl.seccondButton.setTitleColor(.white, for: .normal)
        
        CustomSegmentControl.thirdButton.setTitle("Tổng Kết", for: .normal)
        CustomSegmentControl.thirdButton.setTitleColor(.white, for: .normal)
        
        scoreboardImageView.contentMode = .scaleAspectFit
        
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
        scrollView.delegate = self
        
    }
    //MARK: - Helper
    
    func changescoreboardimage(x: Int) {
        switch x {
        case 1:
            downloadImage(urlstring: scoreboardimageurl[x-1])
        case 2:
            downloadImage(urlstring: scoreboardimageurl[x-1])
        case 3:
            downloadImage(urlstring: scoreboardimageurl[x-1])
        default:
            return
        }
        
    }
    
    func downloadImage(urlstring: String) {
        if let cachedimage = imagecache.object(forKey: urlstring as NSString) as? UIImage {
            self.scoreboardImageView.image = cachedimage
        }
        else {
            DispatchQueue.global().async {
                guard let photourl = URL(string: urlstring) ,let data = try? Data.init(contentsOf: photourl)  else {
                    DispatchQueue.main.async {
                        self.scoreboardImageView.image = UIImage(named: "Unknown")
                    }
                    return
                }
                let downloadedimage = UIImage.init(data: data)
                self.cache.setObject(downloadedimage!, forKey: urlstring as NSString)
                
                DispatchQueue.main.async {
                    self.scoreboardImageView.image = downloadedimage
                }
            }
        }
    }
    
}

//MARK: - UIScrollViewDelegate
extension ScoreboardScreenController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scoreboardImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = scoreboardImageView.image {
                let ratioW = scoreboardImageView.frame.width / image.size.width
                let ratioH = scoreboardImageView.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth*scrollView.zoomScale > scoreboardImageView.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - scoreboardImageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight*scrollView.zoomScale > scoreboardImageView.frame.height
                
                let top = 0.5 * (conditioTop ? newHeight - scoreboardImageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
