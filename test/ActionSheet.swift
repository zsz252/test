//
//  ActionSheet.swift
//  test
//
//  Created by apple on 2017/1/1.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
protocol ActionSheetDelegate {
    func buttonClicked(index:Int)
}
class ActionSheet: UIViewController {
    
    var layview:UIView!
    var width:CGFloat!
    var height:CGFloat!
    var CancelButton:UIButton!
    var btnArray = [UIButton()]
    
    let buttonHeight:CGFloat = 50
    
    var delegate:ActionSheetDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.width = self.view.bounds.size.width
        self.height = self.view.bounds.size.height
        
        self.modalPresentationStyle = .overFullScreen
        self.view.backgroundColor = UIColor.clear
        btnArray = Array()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ActionSheet.tap))
        self.view.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tap(){
        self.dismiss(animated: true) { 
            
        }
    }
    
    func addCancelButtonWithTitle(title:String){
        if(layview == nil){
            layview = UIView(frame: CGRect(x: width*0.1, y: height-buttonHeight-30 , width: width*0.8 , height: buttonHeight))
            layview.layer.cornerRadius = 5
            layview.layer.masksToBounds = true
            layview.alpha = 0.8
            self.view.addSubview(layview)
        }else{
            var nowHeight = self.layview.bounds.size.height
            nowHeight += 60
            layview.frame = CGRect(x: width*0.1, y: height-nowHeight , width: width*0.8 , height: nowHeight)
        }
        
        if(CancelButton == nil){
            CancelButton = UIButton(frame: CGRect(x: 0, y: buttonHeight*(CGFloat)(btnArray.count) + 10, width: width*0.8, height: buttonHeight))
            CancelButton.setTitle(title, for: .normal)
            CancelButton.layer.cornerRadius = 5
            CancelButton.layer.masksToBounds = true
            CancelButton.backgroundColor = UIColor.brown
            CancelButton.addTarget(self, action: #selector(self.tap), for:.touchUpInside)
            self.layview.addSubview(CancelButton)
        }
    }
    
    func addButtonWithTitle(title:String){
        if(layview == nil){
            layview = UIView(frame: CGRect(x: width*0.1, y: height-buttonHeight-30 , width: width*0.8 , height: buttonHeight))
            layview.layer.cornerRadius = 5
            layview.layer.masksToBounds = true
            layview.alpha = 0.8
            self.view.addSubview(layview)
        }else{
            var nowHeight = self.layview.bounds.size.height
            nowHeight += 50
            layview.frame = CGRect(x: width*0.1, y: height-nowHeight-30 , width: width*0.8 , height: nowHeight)
        }
        
        let btn = UIButton(frame: CGRect(x: 0, y: (CGFloat)(btnArray.count)*buttonHeight, width: width*0.8, height: buttonHeight-1))
        btn.tag = btnArray.count
        btn.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
        btn.backgroundColor = UIColor.red
        btn.setTitle(title, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        layview.addSubview(btn)
        btnArray.append(btn)
        if(CancelButton != nil ){
            let CancelY = CancelButton.frame.origin.y
            CancelButton.frame = CGRect(x: 0, y: CancelY + buttonHeight , width: width*0.8, height: buttonHeight)
        }
    }
    
    func buttonClicked(sender:Any){
        self.dismiss(animated: true) { 
            
        }
        
        let btn = sender as! UIButton
        delegate.buttonClicked(index: btn.tag)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
