//
//  ViewController.swift
//  Instagrid
//
//  Created by Fabrice Etiennette on 09/07/2019.
//  Copyright © 2019 Fabrice Etiennette. All rights reserved.
//

import UIKit
import Photos


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Swipe to share stack view
    @IBOutlet weak var SwipeToShare: UIStackView!
    
    // Frame Image view and Button
    @IBOutlet weak var TopLeftImageView: UIImageView!
    @IBOutlet weak var TopLeftButton: UIButton!
    
    @IBOutlet weak var TopRightImageView: UIImageView!
    @IBOutlet weak var TopRightButton: UIButton!
    
    @IBOutlet weak var LeftDownImageView: UIImageView!
    @IBOutlet weak var LeftDownButton: UIButton!
    
    @IBOutlet weak var RightDownImageView: UIImageView!
    @IBOutlet weak var RightDownButton: UIButton!

    // Frame UI view
    @IBOutlet weak var LeftTopView: UIView!
    @IBOutlet weak var RightTopView: UIView!
    @IBOutlet weak var LeftDownView: UIView!
    @IBOutlet weak var RightDownView: UIView!
    
    // Frame Selection Button
    @IBOutlet weak var FirstButton: UIButton!
    @IBOutlet weak var SecondButton: UIButton!
    @IBOutlet weak var ThirdButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragged(gestureRecognizer:)))
        SwipeToShare.isUserInteractionEnabled = true
        SwipeToShare.addGestureRecognizer(panGesture)
    }
    
    // MARK: - ChooseImage method
    
    @IBAction func chooseImage(_ sender: UIButton) {
        
        switch sender {
        case TopLeftButton:
            self.TopLeftButton.isSelected = true
        case TopRightButton:
            self.TopRightButton.isSelected = true
        case LeftDownButton:
            self.LeftDownButton.isSelected = true
        case RightDownButton:
            self.RightDownButton.isSelected = true
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if TopLeftButton.isSelected == true {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            TopLeftImageView.image = image
            TopLeftButton.alpha = 0.02
            TopLeftButton.isSelected = false
            picker.dismiss(animated: true, completion: nil)
        }
        else if TopRightButton.isSelected == true {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            TopRightImageView.image = image
            TopRightButton.alpha = 0.02
            TopRightButton.isSelected = false
            picker.dismiss(animated: true, completion: nil)
        }
        else if RightDownButton.isSelected == true {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            RightDownImageView.image = image
            RightDownButton.alpha = 0.02
            RightDownButton.isSelected = false
            picker.dismiss(animated: true, completion: nil)
        }
        else if LeftDownButton.isSelected == true {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            LeftDownImageView.image = image
            LeftDownButton.alpha = 0.02
            LeftDownButton.isSelected = false
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Swipe to share method
    
    @objc func dragged(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began {
            print("Began")
        }
        else if  gestureRecognizer.state == .changed {
            SwipeToShare.transform = CGAffineTransform(translationX: 0, y: -50)
        }
        else if gestureRecognizer.state == .ended {
            UIStackView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping:  0.2, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.SwipeToShare.transform = .identity
            })
        }
    }
    
    // MARK: - Frame selection method
    
    @IBAction func FrameSelect(_ sender: UIButton) {
        LeftTopView.isHidden = false
        LeftDownView.isHidden = true
        
        switch sender {
        case FirstButton:
            LeftTopView.isHidden = true
            LeftDownView.isHidden = false
            FirstButton.isSelected = true
            SecondButton.isSelected = false
            ThirdButton.isSelected = false
        case SecondButton:
            LeftDownView.isHidden = true
            FirstButton.isSelected = false
            SecondButton.isSelected = true
            ThirdButton.isSelected = false
        case ThirdButton:
            LeftDownView.isHidden = false
            LeftTopView.isHidden = false
            FirstButton.isSelected = false
            SecondButton.isSelected = false
            ThirdButton.isSelected = true
        default:
            break;
        }
    }
    
}

