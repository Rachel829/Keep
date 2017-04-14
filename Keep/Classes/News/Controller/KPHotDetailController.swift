//
//  KPHotDetailController.swift
//  Keep
//
//  Created by Damon on 17/4/7.
//  Copyright © 2017年 Damon. All rights reserved.
//

import UIKit

let KPNewsDetailAuthorCellIdentifier = "KPNewsDetailAuthorCellIdentifier"
let KPNewsFollowCellIdentifier = "KPNewsFollowCellIdentifier"
let KPNewsRecommendUserCellIdentifier = "KPNewsRecommendUserCellIdentifier"

class KPHotDetailController: KPBaseViewController {

    var tableView: UITableView?

    var userID: String?
    
    var likers = [KPNewsLikersItem]()
    
    var hotDetailItem: KPHotDetailItem?
    
    var comments = [KPNewsCommentsItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        loadDetailData()
    }
    
    fileprivate func loadDetailData() {

        KPNetworkTool.shareNetworkTool.loadNewsHotDetailData(userID: userID) { [weak self]
            
            (hotDetailItem) in
            
            if let hotDetailItem = hotDetailItem {
                
                self?.hotDetailItem = hotDetailItem
                
                
            }
            
            if let likerArray = hotDetailItem?.likers {
            
                self?.likers = likerArray
                
                
            }
            
            self?.tableView?.reloadData()
        }
        
        
        KPNetworkTool.shareNetworkTool.loadNewsHotCommentsData(userID: userID) {[weak self]
            
            (comments) in
            
               self?.comments = comments!
            
               self?.tableView?.reloadData()
            }
    }
    
    fileprivate func setupUI() {
    
        navigationItem.title = "动态详情"
        view.backgroundColor = KPBg()
        
        let rightItem = UIBarButtonItem(image: UIImage(named: "personal_message_center_icon"), style: .plain, target: self, action: #selector(likeClick))
        
        navigationItem.rightBarButtonItem = rightItem
        
        let tableView = UITableView.init(frame: view.bounds, style: .grouped)
        
        tableView.register(KPNewsDetailAuthorCell.self, forCellReuseIdentifier: KPNewsDetailAuthorCellIdentifier)
        
        tableView.register(KPNewsFollowCell.self, forCellReuseIdentifier: KPNewsFollowCellIdentifier)
        
        tableView.register(KPNewsRecommendUserCell.self, forCellReuseIdentifier: KPNewsRecommendUserCellIdentifier)

        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        self.tableView = tableView
    }
    
    @objc fileprivate func likeClick() {
    
    
    }
    
}

extension KPHotDetailController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        if indexPath.section == 1 {
        
            let likeListVC = KPNewsLikeListController()
            likeListVC.userID = userID
            self.navigationController?.pushViewController(likeListVC, animated: true)
        }
    }
}

extension KPHotDetailController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 || section == 1 {
            return 1
        }
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KPNewsDetailAuthorCellIdentifier) as! KPNewsDetailAuthorCell
            cell.hotDetailItem = hotDetailItem
            
            return cell
        } else if indexPath.section == 1 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: KPNewsFollowCellIdentifier) as! KPNewsFollowCell
            return cell

        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KPNewsRecommendUserCellIdentifier) as! KPNewsRecommendUserCell
            
            cell.commentsItem = comments[indexPath.row]
            
            return cell

        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 500
        } else if indexPath.section == 1 {
        
            return 44
        }
        return 90
    }
    
}


