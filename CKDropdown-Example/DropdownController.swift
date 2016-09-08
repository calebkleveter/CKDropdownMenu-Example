//
//  DropdownController.swift
//  CKDropdown-Example
//
//  Created by Caleb Kleveter on 9/6/16.
//  Copyright © 2016 Caleb Kleveter. All rights reserved.
//

import UIKit
import CKDropdownMenu

class DropdownController: DropdownMenuController {

    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // Custom initialization
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Customize your menu programmatically here.
        self.customizeMenu()
    }
    
    func customizeMenu() {
        var imageColor: UIColor? = .white()
        // EXAMPLE: To set the menubar background colour programmatically.
        // FYI: There is a bug where the color comes out differently when set programmatically
        // than when set in XCode Interface builder, and I don't know why.
        //[self setMenubarBackground:[UIColor greenColor]];
        // Replace menu button with an IonIcon.
        self.menuButton.setTitle(nil, for: [])
        self.menuButton.setImage(IonIcons.imageWithIcon(icon_name: icon_navicon, size: 30.0, color: &imageColor), for: [])
        //Uncomment to stop drop 'Triangle' from appearing
        //[self dropShapeShouldShowWhenOpen:NO];
        //Uncomment to fade to white instead of default (black)
        //[self setFadeTintWithColor:[UIColor whiteColor]];
        //Uncomment for increased fade effect (default is 0.5f)
        //[self setFadeAmountWithAlpha:0.2f];
        // Style menu buttons with IonIcons.
        for button: UIButton in self.buttons {
            if let titleLabel = button.titleLabel {
                if titleLabel.text == "Profile" {
                    IonIcons.label(label: titleLabel, setIcon: icon_navicon_round, size: 15.0, color: .white(), sizeToFit: false)
                    button.setImage(IonIcons.imageWithIcon(icon_name: icon_person, size: 20.0, color: &imageColor), for: [])
                }
                else if titleLabel.text == "Home" {
                    IonIcons.label(label: titleLabel, setIcon: icon_home, size: 15.0, color: .white(), sizeToFit: false)
                    button.setImage(IonIcons.imageWithIcon(icon_name: icon_home, size: 20.0, color: &imageColor), for: [])
                }
                else if titleLabel.text == "Photos" {
                    IonIcons.label(label: titleLabel, setIcon: icon_image, size: 15.0, color: .white(), sizeToFit: false)
                    button.setImage(IonIcons.imageWithIcon(icon_name: icon_image, size: 20.0, color: &imageColor), for: [])
                }
                
                // Set the title and icon position
                button.sizeToFit()
                
                if let imageView = button.imageView {
                    button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageView.frame.size.width - 10, 0, imageView.frame.size.width)
                } else {
                    return
                }
                button.imageEdgeInsets = UIEdgeInsetsMake(0, titleLabel.frame.size.width, 0, -titleLabel.frame.size.width)
                // Set color to white
                button.setTitleColor(.white(), for: [])
            } else {
                return
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
