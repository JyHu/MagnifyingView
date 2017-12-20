//
//  ViewController.swift
//  MagnifyingDemo
//
//  Created by 胡金友 on 2017/12/19.
//

import UIKit
import MagnifyingView

class ViewController: UIViewController {
    
    @IBOutlet weak var factorLabel: UILabel!
    
    var touchView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 4))
    var loupe:MagnifyingView = MagnifyingView(frame: CGRect(x: 10, y: 74, width: 300, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.touchView.backgroundColor = UIColor.red
        self.view.addSubview(self.touchView)
        
        self.loupe.magnifyView = self.view
        self.loupe.isHidden = true
        self.view.addSubview(self.loupe)
    }

    @IBAction func changeFactor(_ sender: UISlider) {
        self.factorLabel.text = "\(sender.value)"
        self.loupe.scaleFactor = CGFloat(sender.value)
    }
    
    @IBAction func changeShape(_ sender: UISwitch) {
        if sender.isOn {
            self.loupe.magnifyShap = .Round
        } else {
            self.loupe.magnifyShap = .Square
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.loupe.isHidden = false
        magnifyingTouch(touch: ((touches as NSSet).anyObject() as! UITouch))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        magnifyingTouch(touch: ((touches as NSSet).anyObject() as! UITouch))
    }
    
    func magnifyingTouch(touch:UITouch) {
        let point = touch.location(in: self.view)
        self.loupe.touchLocation = point
        self.touchView.center = point
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

