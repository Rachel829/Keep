//
//  KPTrainViewController.swift
//  Keep
//
//  Created by Damon on 17/3/8.
//  Copyright © 2017年 Damon. All rights reserved.
//

import UIKit
import SwiftyJSON
import SWTableViewCell
import AVFoundation


let KPTrainPlanListCellIdentifier = "KPTrainPlanListCellIdentifier"

class KPTrainViewController: UIViewController {

    var tableView: UITableView?

    var av:AVSpeechSynthesizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        navigationItem.titleView = titleView

        let rightItem = UIBarButtonItem(image: UIImage(named: "icon_run_sign"), style: .plain, target: self, action: #selector(rightItemClick))
        navigationItem.rightBarButtonItem = rightItem
        
        setupUI()
        
    }
    
    @objc fileprivate func buttonClick() {
    
        DispatchQueue.global().async {
        }
        
        DispatchQueue.main.async {
        }
        
        self.av = AVSpeechSynthesizer()
        self.av?.delegate = self;
        let utterance = AVSpeechUtterance(string: "开始倒计时, 五秒，5秒，九秒，15秒，100秒，跑步结束,跑步距离5公里，用时50分钟,每公里平均用时10分钟。您已跑步1公里，用时10分钟，最近一公里用时4分钟。离目标还有30分钟，加快速度，加油吧！恭喜你，跑步5公里目标已达成，请确认是否结束本次跑步？")
        utterance.rate = 0.5;
        let voice = AVSpeechSynthesisVoice(language: "zh-CN")
        utterance.voice = voice;
        self.av?.speak(utterance)
        
    }
    
    fileprivate func setupUI() {
        
        let tableView = UITableView.init(frame: view.bounds, style: .plain)
        tableView.backgroundColor = KPTable()
        
        tableView.register(KPTrainPlanListCell.self, forCellReuseIdentifier: KPTrainPlanListCellIdentifier)
        
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        self.tableView = tableView
    }
    
    func rightItemClick() {
        let runRecordVc = KPTrainRunRecordController()
        let nav = KPNavigationController.init(rootViewController: runRecordVc)
        self.present(nav, animated: true, completion:
        nil)
    }
    
    fileprivate lazy var titleView: UIImageView = {
        let titleView = UIImageView()
        titleView.image = UIImage(named: "keep_logo")
        titleView.frame = CGRect(x: 0, y: 0, width: 50, height: 23)
        return titleView
    }()
    
}


extension KPTrainViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.section == 1 {
            
        }
    }
}

extension KPTrainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KPTrainPlanListCellIdentifier) as! KPTrainPlanListCell
        
        cell.delegate = self;

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
}


extension KPTrainViewController: SWTableViewCellDelegate {

    func swipeableTableViewCell(_ cell: SWTableViewCell!, didTriggerLeftUtilityButtonWith index: Int) {
    
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell!, didTriggerRightUtilityButtonWith index: Int) {
    
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell!, scrollingTo state: SWCellState) {
    
    }
    
    func swipeableTableViewCellShouldHideUtilityButtons(onSwipe cell: SWTableViewCell!) -> Bool {
    
        return true
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell!, canSwipeTo state: SWCellState) -> Bool {
    
        return true
    }
    
    func swipeableTableViewCellDidEndScrolling(_ cell: SWTableViewCell!) {
    
    }
    
}

extension KPTrainViewController: AVSpeechSynthesizerDelegate {

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        
        print("Start")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        
        print("Pause")

    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        print("Cancel")

    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("Finish")

    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        print("SpeakRangeOfSpeechString")

    }
}


