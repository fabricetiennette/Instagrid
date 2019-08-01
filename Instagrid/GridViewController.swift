//
//  ViewController.swift
//  Instagrid
//
//  Created by Fabrice Etiennette on 09/07/2019.
//  Copyright © 2019 Fabrice Etiennette. All rights reserved.
//

import UIKit
import Photos


class GridViewController: UIViewController {
    
    // Swipe to share stack view
    @IBOutlet private weak var swipeToShareStackView: UIStackView!
    
    // Frame Image view and Button
    @IBOutlet private weak var topLeftImageView: UIImageView!
    @IBOutlet private weak var topLeftButton: UIButton!
    
    @IBOutlet private weak var topRightImageView: UIImageView!
    @IBOutlet private weak var topRightButton: UIButton!
    
    @IBOutlet private weak var leftDownImageView: UIImageView!
    @IBOutlet private weak var leftDownButton: UIButton!
    
    @IBOutlet private weak var rightDownImageView: UIImageView!
    @IBOutlet private weak var rightDownButton: UIButton!
    
    // Frame UI view
    @IBOutlet private weak var leftTopView: UIView!
    @IBOutlet private weak var rightTopView: UIView!
    @IBOutlet private weak var leftDownView: UIView!
    @IBOutlet private weak var rightDownView: UIView!
    
    // Frame Selection Button
    @IBOutlet private weak var firstButton: UIButton!
    @IBOutlet private weak var secondButton: UIButton!
    @IBOutlet private weak var thirdButton: UIButton!
    
    @IBOutlet private weak var photoFrameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragged(gestureRecognizer:)))
        swipeToShareStackView.isUserInteractionEnabled = true
        swipeToShareStackView.addGestureRecognizer(panGesture)
    }
}

extension GridViewController: UINavigationControllerDelegate {}

// MARK: - ChooseImage method
extension GridViewController: UIImagePickerControllerDelegate {
    
    @IBAction func chooseImage(_ sender: UIButton) {
        
        switch sender {
        case topLeftButton:
            self.topLeftButton.isSelected = true
        case topRightButton:
            self.topRightButton.isSelected = true
        case leftDownButton:
            self.leftDownButton.isSelected = true
        case rightDownButton:
            self.rightDownButton.isSelected = true
        default:
            break;
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera not available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func displayImage(image: UIImage, imageView: UIImageView, button: UIButton) {
        imageView.image = image
        button.alpha = 0.02
        button.isSelected = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        if topLeftButton.isSelected {
            displayImage(image: image, imageView: topLeftImageView, button: topLeftButton)
        } else if topRightButton.isSelected {
            displayImage(image: image, imageView: topRightImageView, button: topRightButton)
        } else if rightDownButton.isSelected  {
            displayImage(image: image, imageView: rightDownImageView, button: rightDownButton)
        } else if leftDownButton.isSelected  {
            displayImage(image: image, imageView: leftDownImageView, button: leftDownButton)
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Swipe to share method
    
    @objc func dragged(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began {
            print("Began")
        } else if  gestureRecognizer.state == .changed {
            swipeToShareStackView.transform = CGAffineTransform(translationX: 0, y: -50)
            print("changed")
        } else if gestureRecognizer.state == .ended {
            UIStackView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping:  0.2, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.swipeToShareStackView.transform = .identity
                print("back!!")
            })
            let imageToShare = photoFrameView.getImage()
            let shareActivity = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
            present(shareActivity, animated: true, completion: nil)
        }
    }
    
    // MARK: - Frame selection method
    
    @IBAction func FrameSelect(_ sender: UIButton) {
        
        photoFrameView.flash()
        
        leftTopView.isHidden = false
        leftDownView.isHidden = true
        
        switch sender {
        case firstButton:
            leftTopView.isHidden = true
            leftDownView.isHidden = false
            firstButton.isSelected = true
            secondButton.isSelected = false
            thirdButton.isSelected = false
        case secondButton:
            leftDownView.isHidden = true
            firstButton.isSelected = false
            secondButton.isSelected = true
            thirdButton.isSelected = false
        case thirdButton:
            leftDownView.isHidden = false
            leftTopView.isHidden = false
            firstButton.isSelected = false
            secondButton.isSelected = false
            thirdButton.isSelected = true
        default:
            break;
        }
    }
}
