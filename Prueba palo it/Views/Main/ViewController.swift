//
//  ViewController.swift
//  Prueba palo it
//
//  Created by Carlos Ardila on 14/03/22.
//

import UIKit
import RxSwift
import Toast_Swift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var arrayPosts: [Post] = []
    let viewModel = MainViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponents()
    }
    
    //initialize UI components of view controller
    func initUIComponents() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        addObservers()
        self.viewModel.loadPost()
        
        //Navigation Controllrt
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = self.navigationController?.navigationBar.backgroundColor
            appearance.shadowColor = nil
            self.navigationController?.navigationBar.standardAppearance = appearance;
            self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        }
    }
    
    func addObservers() {
        //result of load posts observer
        viewModel.postResult.subscribe(onNext: { [weak self] result in
            guard let self = self else { return }
            self.arrayPosts = result
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        //toast message observer
        viewModel.toastMessage.subscribe(onNext: { [weak self] result in
            guard let self = self else { return }
            self.view.makeToast(result)
        }).disposed(by: disposeBag)
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath)
        let model = arrayPosts[indexPath.row]
        cell.textLabel?.text = model.title
        cell.textLabel?.textColor = #colorLiteral(red: 0.1412822902, green: 0.1410127878, blue: 0.1497790515, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = arrayPosts[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "detail") as? PostDetailViewController
        if let nextVC = vc {
            nextVC.model = model
            nextVC.viewModel = self.viewModel
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

