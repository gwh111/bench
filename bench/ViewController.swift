//
//  ViewController.swift
//  bench
//
//  Created by gwh on 2022/1/8.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        print(b.isDebug())
//        self.setupRoot()
        
        //test.test();
        b.httpTask()
        b.event().dispatchEvent("", data: nil)
        UIButton.b_backButton()
    }


}

