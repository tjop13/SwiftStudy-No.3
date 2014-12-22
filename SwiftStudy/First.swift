//
//  ViewController.swift
//  List
//
//  Created by Takuro Mori on 2014/11/25.
//  Copyright (c) 2014年 Takuro Mori. All rights reserved.
//

import UIKit

class First: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //<グローバル変数宣言>
    var tableView = UITableView()
    var DrawButton = UIButton()
    var inputArray : [UIImage] = [UIImage]()
    var selectImage : UIImage!
    
    
    //<初期化>
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 0.6, alpha: 1.0)
        
        //tableview
        tableView.frame = CGRectMake(10, 20, 300, 450)
        tableView.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 0.6, alpha: 1.0)
        tableView.separatorColor = UIColor.clearColor()
        tableView.dataSource = self
        tableView.delegate = self
        var nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "IllustCell")
        self.view.addSubview(tableView)
        
        //イラスト画面へ移るボタン
        DrawButton.frame = CGRectMake(110, 480, 100, 30)
        DrawButton.backgroundColor = UIColor.blueColor()
        DrawButton.setTitle("Draw", forState: .Normal)
        DrawButton.layer.cornerRadius = 10.0
        DrawButton.addTarget(self, action: "Drawbutton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(DrawButton)
    }
    
    //<メモリが足りなくなった時>
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //<画面が現れた時>
    override func viewDidAppear(animated: Bool) {
        if inputArray.count != 0{
            tableView.reloadData()
            var indexPath = NSIndexPath(forItem: inputArray.count-1, inSection: 0)
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        }
    }
    
    
    //<Inputボタンを押した時>
    func Drawbutton(sender : UIButton){
        self.performSegueWithIdentifier("toIllust", sender: self)
    }
    
    //<各セルが選択された時>
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectImage = inputArray[indexPath.row]
        self.performSegueWithIdentifier("toSecond", sender: self)
    }
    
    //<セルの高さ>
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    //<リストに表示する要素数>
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputArray.count
    }
    
    //<リストに表示する中身>
    //リストに表示する要素数分呼び出され、その度indexPath.rowの値でインクリメントが行われる。
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("IllustCell", forIndexPath: indexPath) as CustomCell
        cell.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.8, alpha: 0.85)
        cell.IllustImage?.image = inputArray[indexPath.row]
        return cell
    }
    
    
    //<画面遷移時に値を渡す>
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSecond"{
            var VC : Second = segue.destinationViewController as Second
            VC.selectImage = self.selectImage
            VC.Image_Array = self.inputArray
        }
        if segue.identifier == "toIllust"{
            var VC : Illust = segue.destinationViewController as Illust
            VC.Illust_Array = self.inputArray
        }
    }
    
}

