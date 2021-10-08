//
//  ShowBiggerPictureViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 08/10/2021.
//

import UIKit

class ShowBiggerPictureViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    
    
    var image: UIImage! = UIImage(named: "Unknown")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        
    }
    
    private func viewConfig() {
        self.view.backgroundColor = UIColor().ContainerViewColor()
        
        topView.layer.borderWidth = 0.5
        topView.layer.borderColor = UIColor.darkGray.cgColor
        topView.backgroundColor = UIColor().ContainerViewColor()
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        pictureImageView.contentMode = .scaleAspectFit
        pictureImageView.image = image
        
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
        scrollView.delegate = self
    }
    
    @IBAction func doneButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ShowBiggerPictureViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return pictureImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = pictureImageView.image {
                let ratioW = pictureImageView.frame.width / image.size.width
                let ratioH = pictureImageView.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth*scrollView.zoomScale > pictureImageView.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - pictureImageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight*scrollView.zoomScale > pictureImageView.frame.height
                
                let top = 0.5 * (conditioTop ? newHeight - pictureImageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
