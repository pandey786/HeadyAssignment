//
//  IndicatableViewExtension.swift
//  HeadyAssignment
//
//  Created by Durgesh Pandey on 06/02/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension IndicatableView where Self: UIViewController {
    
    func showActivityIndicator() {
        SVProgressHUD.show()
    }
    
    func hideActivityIndicator() {
        SVProgressHUD.dismiss()
    }
}
