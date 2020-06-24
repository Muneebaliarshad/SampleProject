//
//  BaseViewController.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import Foundation
import UIKit


class BaseViewController: UIViewController {

    //MARK: - Variables
    var leftSearchBarButtonItem : UIBarButtonItem?
    var rightSearchBarButtonItem : UIBarButtonItem?
    

    //MARK: - View Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = item
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getLabelsInView(view: UIView) -> [UILabel] {
        var results = [UILabel]()
        for subview in view.subviews {
            if subview is UILabel {
              
                results += [subview as! UILabel]
            } else {
                results += getLabelsInView(view: subview)
            }
        }
        return results
    }
    


    //MARK: - Navigation Methods
    func setupColorNavigationBar() {
        if let font = UIFont(name: "Roboto-Bold", size: CGFloat(getFontSize())){
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
            navigationController?.navigationBar.barStyle = .default
        }
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

 

    //MARK: - Helper Methods
    func getFontSize() -> Int{
        if DeviceType.IS_IPHONE_4_OR_LESS {
            return 16
        }
        return 20
    }


}
