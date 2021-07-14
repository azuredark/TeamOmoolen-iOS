//
//  TabBarController.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setTabBar()
    }
    
    func setUI() {
        UITabBar.appearance().tintColor = UIColor.omMainBlack
    }
    
    func setTabBar() {
        let homeStoryboard = UIStoryboard.init(name: "Home", bundle: nil)
        let homeTab = homeStoryboard.instantiateViewController(identifier: "NaviController")
        homeTab.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "abc"), selectedImage: UIImage(named: "abc"))
        
        
        let suggestStoryboard = UIStoryboard.init(name: "Suggest", bundle: nil)
        let suggestTab = suggestStoryboard.instantiateViewController(identifier: "NaviController")
        suggestTab.tabBarItem = UITabBarItem(title: "발견", image: UIImage(named: "abc"), selectedImage: UIImage(named: "abc"))
        
        let eventStoryboard = UIStoryboard.init(name: "Event", bundle: nil)
        let eventTab = eventStoryboard.instantiateViewController(identifier: "EventVC")
        eventTab.tabBarItem = UITabBarItem(title: "이벤트", image: UIImage(named: "abc"), selectedImage: UIImage(named: "abc"))
        
        let tipStoryboard = UIStoryboard.init(name: "Tip", bundle: nil)
        let tipTab = tipStoryboard.instantiateViewController(identifier: "TipVC")
        tipTab.tabBarItem = UITabBarItem(title: "꿀팁", image: UIImage(named: "abc"), selectedImage: UIImage(named: "abc"))
        
        let myStoryboard = UIStoryboard.init(name: "MyPage", bundle: nil)
        let myTab = myStoryboard.instantiateViewController(identifier: "MyPageVC")
        myTab.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "abc"), selectedImage: UIImage(named: "abc"))
        
        // 탭 연결
        let tabs =  [homeTab, suggestTab, eventTab, tipTab, myTab]
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSansCJKKR-Medium", size: 9)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = homeTab
    }

}
