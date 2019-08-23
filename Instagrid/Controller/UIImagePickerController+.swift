//
//  UIImagePickerController+.swift
//  Instagrid
//
//  Created by Fabrice Etiennette on 20/08/2019.
//  Copyright © 2019 Fabrice Etiennette. All rights reserved.
//

import UIKit

// extension of UIImagePickerController with help me to rotate my picker
extension UIImagePickerController {
    open override var shouldAutorotate: Bool { return true }
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .all }
}
