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
            scoreboardImageView.image = UIImage(named: "Unknown")
        case 2:
            return
        case 3:
            return
        default:
            return
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
