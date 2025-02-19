//
//  DetailVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/08.
//

import UIKit

class DetailVC: UIViewController {
    
    // MARK: - UI Components
    
    @IBOutlet weak var customNavigationBarView: UIView!
    @IBOutlet weak var detailTableView: UITableView!
    
    private lazy var writeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icWrite"), for: .normal)
        return button
    }()
    
    // MARK: - Local Variables
    var id: String?
    private var lensData: ProductDetailResponse?
    
    
    // MARK: - Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getProductDetailWithAPI() 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()

        registerXib()
        setTableView()
        
        setTabbarController()
        setNavigationController()
        
        
    }
}

extension DetailVC {
    func setUI() {
        view.addSubview(writeButton)
        
        writeButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(700)
        }
    }
    
    func getProductDetailWithAPI() {
        DetailAPI.shared.getProductDetail(param: self.id ?? "") { response in
            self.lensData = response
            self.detailTableView.reloadData()
        }
    }
    
    func registerXib() {
        let topNib = UINib(nibName: DetailTopTVC.identifier, bundle: nil)
        detailTableView.register(topNib, forCellReuseIdentifier: DetailTopTVC.identifier)
        
        let reviewNib = UINib(nibName: ReviewTVC.identifier, bundle: nil)
        detailTableView.register(reviewNib, forCellReuseIdentifier: ReviewTVC.identifier)
        
        let similarNib = UINib(nibName: DetailSimilarTVC.identifier, bundle: nil)
        detailTableView.register(similarNib, forCellReuseIdentifier: DetailSimilarTVC.identifier)
        
        let newNib = UINib(nibName: DetailNewTVC.identifier, bundle: nil)
        detailTableView.register(newNib, forCellReuseIdentifier: DetailNewTVC.identifier)
    }
    
    func setTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        detailTableView.separatorStyle = .none
    }
    
    func setTabbarController() {
        tabBarController?.tabBar.isHidden = true
    }
    
    func setNavigationController() {
        setupNavigationBar(customNavigationBarView: customNavigationBarView, title: "제품 상세 정보")
    
        navigationController?.navigationBar.isHidden = true
    }
}

extension DetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 838
        case 1:
            return 1315
        case 2:
            return 756
        case 3:
            return 375
        default:
            return UITableView.automaticDimension
        }
    }
}

extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTopTVC.identifier) as? DetailTopTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.delegate = self
            
            let data = lensData
            cell.initCell(imageList: data?.imageURL ?? ["", "", ""], brand: data?.brand ?? "", lens: data?.name ?? "", price: data?.price ?? 0, diameter: data?.diameter ?? 0, minCycle: data?.changeCycleMinimum ?? 0, maxCycle: data?.changeCycleMaximum ?? 0, texture: data?.material ?? "", function: data?.function ?? "", colorList: data?.otherColorList ?? [""])
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTVC.identifier) as? ReviewTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailSimilarTVC.identifier) as? DetailSimilarTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.delegate = self
            cell.initCell(data: lensData?.suggestList ?? [SuggestList]())
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailNewTVC.identifier) as? DetailNewTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.delegate = self
            cell.initCell(data: lensData?.popularList ?? [PopularList]())
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - Protocol

extension DetailVC: ViewModalProtocol {
    func detailViewModalDelegate(dvc: DetailVC) {
        navigationController?.pushViewController(dvc, animated: true)
    }
}
