//
//  PopOverViewController.swift
//  HeadyAssignment
//
//  Created by Durgesh Pandey on 06/02/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit

protocol PopOverDelegate {
    func selectedPopOverItem(selectedItem: Any, popOverType: PopOverType)
}

class PopOverViewController: UIViewController {
    
    //Variables
    var dataSourceArray = [Any]()
    var delegate: PopOverDelegate?
    var popOverType: PopOverType!
    var selectedItem: Any?
    
    //Outlets
    @IBOutlet weak var tableViewPopOver: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Up View
        setUpView()
    }
    
    func setUpView() {
        
        //Set Dynamic Row Height for table view
        self.tableViewPopOver.estimatedRowHeight = 50
        self.tableViewPopOver.rowHeight = UITableViewAutomaticDimension
        
        //Register Nibs
        self.tableViewPopOver.register(UINib.init(nibName: "PopOverTableViewCell", bundle: nil), forCellReuseIdentifier: "PopOverTableViewCell")
        self.tableViewPopOver.register(UINib.init(nibName: "PopOverHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "PopOverHeaderTableViewCell")
    }
    
}

extension PopOverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let contentCell: PopOverTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PopOverTableViewCell") as! PopOverTableViewCell
        
        //Configure Content Cell
        let popOverItem = self.dataSourceArray[indexPath.row]
        
        if popOverItem is String {
            
            //Country or City
            contentCell.labelTitle.text = popOverItem as? String
        }
        
        //Set Selected
        if let selectedItem = self.selectedItem {
            
            //Check Item Type
            if popOverItem is String {
                
                //Country or City
                contentCell.imageViewCheckmark.isHidden = (popOverItem as! String == selectedItem as! String) ? false: true
            }
        } else {
            contentCell.imageViewCheckmark.isHidden = true
        }
        
        //Remove Selection style
        contentCell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return contentCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell: PopOverHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PopOverHeaderTableViewCell") as! PopOverHeaderTableViewCell
        
        //Configure Header Cell
        switch popOverType {
        case .SelectSortingOrder:
            headerCell.labelTitle.text = "Sort By"
        default:
            break
        }
        
        return headerCell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = self.dataSourceArray[indexPath.row]
        
        //Set Selected item
        self.selectedItem = selectedItem
        tableView.reloadData()
        
        //Notify Delegate
        self.delegate?.selectedPopOverItem(selectedItem: selectedItem, popOverType: self.popOverType)
        
        //Dismiss PopOver
        self.dismiss(animated: true) {
        }
    }
    
}
