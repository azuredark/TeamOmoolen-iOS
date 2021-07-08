//
//  RecentSearchVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/04.
//

import UIKit

class RecentSearchVC: UIViewController {
    
    // MARK: - Properteis
    private var popularSearchList = [PopularResponse]()

    //Mark: - UI Components
    @IBOutlet weak var searchInTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var recentSearchCellHeight = 120
    
    //Mark: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        setSearchInTableView()
        checkNotification()
        getPopularSearchWithAPI()

        print(searchInTableView.frame.width)

        // Do any additional setup after loading the view.
    }
    
    //Mark: - Methods
    func registerXib(){
        let searchInNib = UINib(nibName:SearchInTVC.identifier, bundle: nil)
        searchInTableView.register(searchInNib, forCellReuseIdentifier: SearchInTVC.identifier)
        
    
        let popularNib = UINib(nibName: PopularTVC.identifier, bundle: nil)
        searchInTableView.register(popularNib, forCellReuseIdentifier: PopularTVC.identifier)
    }
    
    func setSearchInTableView() {
        searchInTableView.delegate = self
        searchInTableView.dataSource = self
        searchInTableView.separatorStyle = .none
    }
    
    func checkNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(setCellHeight), name: NSNotification.Name("AdjustHeight"), object: nil)
    }
    
    //Mark: - objc function
   @objc func setCellHeight(notification: NSNotification){
        if let height = notification.object as? Int {
            recentSearchCellHeight = height
            searchInTableView.reloadData()
    }

    func getPopularSearchWithAPI() {
        SearchAPI.shared.getPopularSearch() { response in
            self.popularSearchList = response
            print(self.popularSearchList)
        }
    }
   }

}

extension RecentSearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section{
        case 0:
            return CGFloat(recentSearchCellHeight)
        case 1:
            return tableViewHeight.constant - CGFloat(recentSearchCellHeight)
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
        return 335
    
    }
}

extension RecentSearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  SearchInTVC.identifier, for: indexPath) as? SearchInTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.backgroundColor = .omWhite
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  PopularTVC.identifier, for: indexPath) as? PopularTVC else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.backgroundColor = .omWhite
            return cell
        default:
            return UITableViewCell()
        }
    }
}


