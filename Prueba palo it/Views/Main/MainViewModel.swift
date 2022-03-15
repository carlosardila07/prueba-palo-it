//
//  MainViewModel.swift
//  Prueba palo it
//
//  Created by Carlos Ardila on 14/03/22.
//

import Foundation
import RxSwift

class MainViewModel {
    
    var business: PostsBusiness? = PostsBusiness()
    let postResult = PublishSubject<[Post]>()
    let commentResult = PublishSubject<[Comment]>()
    let toastMessage = PublishSubject<String>()
    
    deinit {
        self.business = nil
    }
    
    func loadPost() {
        business?.getPosts().done{ result in
            self.postResult.onNext(result)
        }.catch{ error in
            if let error = error as? CustomError {
                self.toastMessage.onNext(error.errorDescription)
            }
        }
    }
    
    func loadComments(id: Int) {
        business?.getComments(postId: id).done{ result in
            self.commentResult.onNext(result)
        }.catch{ error in
            if let error = error as? CustomError {
                self.toastMessage.onNext(error.errorDescription)
            }
        }
    }
}
