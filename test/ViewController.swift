//
//  ViewController.swift
//  test
//
//  Created by apple on 2016/12/11.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import ImagePicker

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,PBViewControllerDelegate,PBViewControllerDataSource,ActionSheetDelegate,ImagePickerDelegate,EAIntroDelegate {
    
    var array = NSMutableArray(array: [1,2,3,4,5,6,7,8,9,10])
    var tableView:UITableView?
    var header:XHPathCover!
    var menu:LLSlideMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView = UITableView(frame: self.view.frame)
        tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.tableFooterView = UIView()
        //tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.headerRefresh))
        tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.footerRefresh))
        header = XHPathCover(frame: CGRect(x: 0, y: 0, width: 375, height: 200))
        header.setBackgroundImage(UIImage(named: "bg.jpg"))
        header.setAvatarImage(UIImage(named: "avatar.png"))
        header.isZoomingEffect = true
        header.setInfo(NSDictionary(objects: ["zsz","ios"], forKeys: [XHUserNameKey as NSCopying,XHBirthdayKey as NSCopying]) as! [NSObject:Any])
        
        header.avatarButton.layer.cornerRadius = 33
        header.avatarButton.layer.masksToBounds = true
        header.avatarButton.addTarget(self, action: #selector(self.photoBrowser), for: .touchUpInside)
        header.handleRefreshEvent = {
            self.headerRefresh()
        }
        
        let Head = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 200 + 60))
        let lineView = LineView(frame: CGRect(x: 0, y: 200, width: 375, height: 60))
        Head.addSubview(header)
        Head.addSubview(lineView)
        self.tableView?.tableHeaderView = Head
        
        self.view.addSubview(tableView!)
        
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk { 
            
        }
        
        //guideView()
        
        menu = LLSlideMenu()
        self.view.addSubview(menu)
        menu.ll_menuWidth = 300
        //menu.ll_menuBackgroundColor = UIColor.red
        menu.ll_menuBackgroundImage = UIImage(named: "bg.jpg")
        //menu.ll_open()
        menu.ll_springDamping = 20
        menu.ll_springVelocity = 15
        menu.ll_springFramesNum = 60
        
        let swipe = UIPanGestureRecognizer(target: self, action: #selector(self.swiped(recognizer:)))
        self.view.addGestureRecognizer(swipe)
        
        let button = UIButton(frame: CGRect(x: 100, y: 620, width: 100, height: 50))
        button.setTitle("关闭菜单", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        menu.addSubview(button)
        button.addTarget(self, action: #selector(self.quitMenu), for: .touchUpInside)
    }
    
    func quitMenu(){
        menu.ll_close()
    }
    
    func swiped(recognizer:UIPanGestureRecognizer){
        if (menu.ll_isOpen || menu.ll_isAnimating) {
            return
        }
        if (recognizer.translation(in: self.view).x < 0 ){
            if(recognizer.state == .cancelled || recognizer.state == .ended){
                menu.ll_close()
            }
        }
        if (recognizer.translation(in: self.view).x > 0 ){
            if(recognizer.state == .changed){
                let swipePoint = recognizer.translation(in: self.view)
                menu.ll_distance = swipePoint.x
            }
            if(recognizer.state == .cancelled || recognizer.state == .ended){
                if menu.ll_distance < 200 {
                    menu.ll_close()
                }else{
                    menu.ll_open()
                }
            }
        }
    }
    
    func headerRefresh(){
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 10000)) {
//            self.array = NSMutableArray(array: [1,2,3,4,5,6,7,8,9,10])
//            self.tableView?.reloadData()
//            self.header.stopRefresh()
//        }
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 2000)) {
            self.array = NSMutableArray(array: [1,2,3,4,5,6,7,8,9,10])
            self.tableView?.reloadData()
            self.header.stopRefresh()
        }
        //tableView?.mj_header.endRefreshing()
    }
    
    func footerRefresh(){
        for i in array.count...(array.count+5) {
            array.add(i+1)
        }
        tableView?.mj_footer.endRefreshing()
        tableView?.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (array.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let image = UIImageView(frame: CGRect(x: 10, y: 10, width: 60, height: 60))
        image.layer.cornerRadius = 30
        image.layer.masksToBounds = true
        image.sd_setImage(with: URL(string:"http://img4.duitang.com/uploads/item/201611/12/20161112201645_CtTLW.thumb.224_0.jpeg"), placeholderImage: UIImage(named:"avatar.png"), options: SDWebImageOptions(rawValue: UInt(0)))
        cell.contentView.addSubview(image)
        
        let label = UILabel(frame: CGRect(x: 80, y: 30, width: 100, height: 20))
        label.text = "第\(array[indexPath.row])行"
        cell.contentView.addSubview(label)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        header.scrollViewDidScroll(scrollView)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        header.scrollViewDidEndDecelerating(scrollView)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        header.scrollViewWillBeginDragging(scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        header.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
    
    func guideView(){
        self.navigationController?.navigationBar.isHidden = true
        let page1 = EAIntroPage()
        page1.bgImage = UIImage(named: "intro1.jpg")
        page1.title = "纲手"
        page1.titleColor = UIColor.black
        page1.titlePositionY = 200
        
        let page2 = EAIntroPage()
        page2.bgImage = UIImage(named: "intro2.jpg")
        page2.title = "自来也"
        page2.titleColor = UIColor.black
        page2.titlePositionY = 200
        
        let page3 = EAIntroPage()
        page3.bgImage = UIImage(named: "intro3.jpg")
        page3.title = "鸣人"
        page3.titleColor = UIColor.black
        page3.titlePositionY = 200
        
        let page4 = EAIntroPage()
        page4.bgImage = UIImage(named: "intro4.jpg")
        page4.title = "卡卡西"
        page4.titleColor = UIColor.black
        page4.titlePositionY = 200
        
        let intro = EAIntroView(frame: self.view.frame, andPages: [page1,page2,page3,page4])
        intro?.delegate = self
        intro?.show(in: self.view)
    }
    
    func photoBrowser(){
//        let vc = PBViewController()
//        vc.pb_delegate = self
//        vc.pb_dataSource = self
//        vc.pb_startPage = 1
//        self.present(vc, animated: true) { 
//            
//        }
        
        let action = ActionSheet()
        action.delegate = self
        action.addCancelButtonWithTitle(title: "取消")
        action.addButtonWithTitle(title: "拍照")
        action.addButtonWithTitle(title: "相册")
        action.addButtonWithTitle(title: "查看高清大图")
        self.present(action, animated: true) { 
            
        }
    }
    
    func numberOfPages(in viewController: PBViewController) -> Int {
        return 1
    }
    
    func viewController(_ viewController: PBViewController, present imageView: UIImageView, forPageAt index: Int, progressHandler: ((Int, Int) -> Void)? = nil) {
        imageView.sd_setImage(with: URL(string:"avatar.png"), placeholderImage: UIImage(named:"avatar.png"), options: SDWebImageOptions(rawValue: UInt(0)))
    }
    
    func viewController(_ viewController: PBViewController, didSingleTapedPageAt index: Int, presentedImage: UIImage?) {
        self.dismiss(animated: true) { 
            
        }
    }
    
    func buttonClicked(index: Int) {
        if(index == 2){
            let vc = PBViewController()
            vc.pb_delegate = self
            vc.pb_dataSource = self
            vc.pb_startPage = 1
            self.present(vc, animated: true) {
                        
            }
        }
        if(index == 1){
            let imagePickerController = ImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.imageLimit = 1
            self.present(imagePickerController, animated: true, completion: { 
                
            })
        }
        if(index == 0){
            ProgressHUD.showError("虚拟机无相机")
        }
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.header.setAvatarImage(images[0])
        self.dismiss(animated: true) { 
            
        }
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        self.dismiss(animated: true) { 
            
        }
    }
    
    func introDidFinish(_ introView: EAIntroView!, wasSkipped: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
}

