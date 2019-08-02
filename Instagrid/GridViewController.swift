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
    
    // Frame grid views table
    @IBOutlet private var gridViews: [UIView]!
    
    // Frame Selection Button table
    @IBOutlet private var groupButtons: [UIButton]!
    
    // Main Frame view
    @IBOutlet private weak var photoFrameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragged(gestureRecognizer:)))
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
    
    // This method is use to display an image and set his button transperant
    func displayImage(image: UIImage, imageView: UIImageView, button: UIButton) {
        imageView.image = image
        button.alpha = 0.02
        button.isSelected = false
    }
    
    // This method is use to pick the image and display in a ui image view
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
    
    // This method is use to interact with the swipe to share stack view with a gesture
    @objc func dragged(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began {
        } else if gestureRecognizer.state == .changed {
            swipeToShareStackView.transform = CGAffineTransform(translationX: 0, y: -50)
        } else if gestureRecognizer.state == .ended {
            UIStackView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping:  0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.swipeToShareStackView.transform = .identity
            })
            
            let imageToShare = photoFrameView.getImage() // get the image from the photoFrameView
            let shareActivity = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil) // share the image
            present(shareActivity, animated: true, completion: nil)
        }
    }
    
    // MARK: - Frame selection method
    
    //  This method is use to change frame when you tape on a button
    @IBAction func frameSelection(_ sender: UIButton) {
        groupButtons.forEach {$0.isSelected = false}
        sender.isSelected = true
        
        switch sender.tag {
        case 1:
            gridViews[1].isHidden = true
            gridViews[2].isHidden = false
        case 2:
            gridViews[1].isHidden = false
            gridViews[2].isHidden = true
        case 3:
            gridViews[1].isHidden = false
            gridViews[2].isHidden = false
        default:
            break;
        }
        photoFrameView.flashAnimation() // Animate the photoFrameView when select a new frame
    }
}
