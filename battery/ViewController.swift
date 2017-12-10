//
//  ViewController.swift
//  battery
//
//  Created by 鈴木海渡 on 2017/10/29.
//  Copyright © 2017年 鈴木海渡. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet var labelBatteryStatus: UILabel!
     @IBOutlet var labelBatteryStatus2: UILabel!
      @IBOutlet weak var yourLabel: UILabel!
    @IBOutlet weak var labelBatteryLevel: UILabel!
     @IBOutlet weak var myDPvar: UIDatePicker!
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var dayOfTheWeekLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
      let weekdayStrings: Array = ["nil","日","月","火","水","木","金","土","日"]//曜日の配列
    
    //NSTimerを利用して60分の1秒ごとに呼びたす。
    func update() {
        getNowTime()
    }
    
    func getNowTime()-> String {
        // 現在時刻を取得
        let nowTime: NSDate = NSDate()
        // 成形する
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        let nowTimeStr = format.string(from: nowTime as Date)
        // 成形した時刻を文字列として返す
        return nowTimeStr
        
        yourLabel.text = String(describing: nowTimeStr)
    }
        

        
       // let myCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!//カレンダーを取得
       // let myComponetns = myCalendar.components(NSCalendar.Unit(rawValue: NSCalendar.Unit.Year.rawValue  |
           // NSCalendar.Unit.CalendarUnitMonth  |
           // NSCalendar.Unit.CalendarUnitDay    |
           // NSCalendar.Unit.CalendarUnitHour   |
           // NSCalendar.Unit.CalendarUnitMinute |
            //NSCalendar.Unit.CalendarUnitSecond |
           // NSCalendar.Unit.CalendarUnitWeekday,
                                                             //    fromDate: myDate),//取得するコンポーネントを決める
       // let weekdayStrings: Array = ["nil","日","月","火","水","木","金","土","日"]//曜日の配列
        /*Storyboardに表示*/
       // var  yearLabel;.stringValue; : "\(myComponetns.year)",
       // yearLabel;.stringValue = "\(myComponetns.year)",
           // monthLabel.stringValue = addZero(String(myComponetns.month), timeNuber: myComponetns.month),
          //  daysLabel.stringValue = addZero(String(myComponetns.day), timeNuber: myComponetns.day),
         //   dayOfTheWeekLabel.stringValue = "\(weekdayStrings[myComponetns.weekday])",
        //    hourLabel.stringValue = addZero(String(myComponetns.hour), timeNuber: myComponetns.hour),
        //    minutesLabel.stringValue = addZero(String(myComponetns.minute), timeNuber: myComponetns.minute),
      //  secondLabel.stringValue = addZero(String(myComponetns.second), timeNuber: myComponetns.second)
        

    
    //1桁のものには0をつける。例えば1秒なら01秒に。
  //  func addZero(timeString:String,timeNuber:Int)->String{
 //       if(countElements(timeString)==1){
   //         return ("0\(timeNuber)")
    //    }else{
    //        return ("\(timeNuber)")
    

    




  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       //watch
       var timer = Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
        
        
        yourLabel.text = getNowTime()
        // 時間管理してくれる
        _ = Timer.scheduledTimer(timeInterval: 60, target: self, selector: "update", userInfo: nil, repeats: true)
        
        
        
        //battery
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        let bLevel:Float = UIDevice.current.batteryLevel
        
        if(bLevel == -1){
            // バッテリーレベルがモニターできないケース
            labelBatteryLevel.text = "計測不能"
        }
        else{
            labelBatteryLevel.text = "  \(bLevel * 100) %"
        }
        
        
        var representedObject: AnyObject? {
            didSet {
                // Update the view, if already loaded.
            }
        }
        
      
       
        //(NSCalendar.Unit.CalendarUnitYear   |
        
        
        //デバイスとバッテリー残量の宣言.
        let myDevice: UIDevice = UIDevice.current
        
        //バッテリー状態の監視.
        myDevice.isBatteryMonitoringEnabled = true
        
        //バッテリープロパティ表示用のラベル.
        let myBatteryLevel = myDevice.batteryLevel
        let myBatteryState = myDevice.batteryState
        
        //バッテリー状態の取得.
        //0.0~1.0で残量表示。残量不明の時は-1.0を返す.
        print("\(myBatteryLevel) %")
        switch (myBatteryState) {
            
        case .full:
            self.view.backgroundColor = UIColor.black
            
        case .unplugged:
            self.view.backgroundColor = UIColor.red
            
        case .charging:
            self.view.backgroundColor = UIColor.black
            
        case .unknown:
            self.view.backgroundColor = UIColor.black
            
        default:
            break;
        }
        
        // Labelを作成.
       // let myLabel = UILabel(frame: CGRect(x:200,y:200,width:200,height:200))
        //myLabel.text = "\(myBatteryLevel * 100) %"
       // myLabel.textColor = UIColor.black
       // self.view.addSubview(myLabel)
        
    
        
    // Battery Status
    var state:String = "バッテリー状態： "
    
    if UIDevice.current.batteryState == UIDeviceBatteryState.unplugged {
    state += "通常"
    }
    
    if UIDevice.current.batteryState == UIDeviceBatteryState.charging {
    state += "充電中"
    }
    
    if UIDevice.current.batteryState == UIDeviceBatteryState.full {
    state += "MAX"
    }
    
    if UIDevice.current.batteryState == UIDeviceBatteryState.unknown {
    state += "不明"
    }
    
    labelBatteryStatus.text = state
        
    

        if ProcessInfo.processInfo.isLowPowerModeEnabled {
            // Low Power Mode is enabled. Start reducing activity to conserve energy.
            labelBatteryStatus2.text = String("ON")
            
            
        } else {
            // Low Power Mode is not enabled.
             labelBatteryStatus2.text = String("OFF")
        }
        
        
     
        }
        
  
       
        
        
        
        
        
        
        
        
        

 
        



        
        
    
    


        
        
        
        
        
        


    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
