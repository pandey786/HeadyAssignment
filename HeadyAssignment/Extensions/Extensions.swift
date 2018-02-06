//
//  Extensions.swift
//  HeadyAssignment
//
//  Created by Durgesh Pandey on 06/02/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

extension UIView {
    
    func setDefaultBorder() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }
    
    func setCollectionCellBorder() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 0
        self.layer.masksToBounds = true
    }
}

extension UIViewController: UIPopoverPresentationControllerDelegate {
    
    func presentPopOverFrom(sourceView: UIView, dataSourceArray: [Any], popOverDelegate: PopOverDelegate, popOverType: PopOverType, selectedItem: Any?) {
        
        let popOverController: PopOverViewController = popOverStoryBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        popOverController.modalPresentationStyle = .popover
        popOverController.dataSourceArray = dataSourceArray
        popOverController.delegate = popOverDelegate
        popOverController.popOverType = popOverType
        popOverController.selectedItem = selectedItem
        
        //Set Content Size for popover
        let popOverHeight = (dataSourceArray.count + 1) * 45 > 250 ? 250 : (dataSourceArray.count + 1) * 45
        popOverController.preferredContentSize = CGSize.init(width: Int(sourceView.frame.size.width), height: popOverHeight)
        
        //Create PopOver presentation
        let popover = popOverController.popoverPresentationController!
        popover.delegate = self
        popover.permittedArrowDirections = .any
        popover.sourceView = sourceView
        popover.sourceRect = sourceView.bounds
        
        //Present PopOver
        self.present(popOverController, animated: true) {
        }
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

extension UIViewController {
    
    func presentAlertWith(alertTitle: String, alertMessage: String) {
        
        let alertCtrl = UIAlertController.init(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        //Add Action
        alertCtrl.addAction(UIAlertAction.init(title: "Ok", style: .destructive, handler: { (alertAction) in
        }))
        
        //present Alert
        self.present(alertCtrl, animated: true, completion: nil)
    }
}


