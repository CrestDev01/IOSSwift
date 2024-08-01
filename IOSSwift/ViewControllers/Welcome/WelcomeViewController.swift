//
//  WelcomeViewController.swift
//  IOSSwift
//
//  Created by CrestAdmin on 25/07/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapLoginButton(_ sender: Any) {
        self.pushViewController(with: Storyboard.main, viewcontroller: AppConstant.viewcontroller.loginVC);
    }
    
    @IBAction func didTapRegisterButton(_ sender: Any) {
        self.pushViewController(with: Storyboard.main, viewcontroller: AppConstant.viewcontroller.registerVC);
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
