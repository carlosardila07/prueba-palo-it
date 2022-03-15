//
//  PostDetailViewController.swift
//  Prueba palo it
//
//  Created by Carlos Ardila on 14/03/22.
//

import UIKit
import RxSwift

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var titlePostLabel: UILabel!
    @IBOutlet weak var bodyPostLabel: UILabel!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    
    //Variables setter in parent controller
    var model: Post?
    var viewModel: MainViewModel?
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponents()
    }
    
    func initUIComponents() {
        self.titlePostLabel.text = model?.title
        self.bodyPostLabel.text = model?.body
        addObservers()
        self.viewModel?.loadComments(id: model?.id ?? 0)
    }
    
    func addObservers() {
        viewModel?.toastMessage.subscribe(onNext: { [weak self] result in
            guard let self = self else { return }
            self.view.makeToast(result)
        }).disposed(by: disposeBag)
        viewModel?.commentResult.subscribe(onNext: { [weak self] result in
            guard let self = self else { return }
            self.numberOfCommentsLabel.text = "\(result.count)"
        }).disposed(by: disposeBag)
    }

}
