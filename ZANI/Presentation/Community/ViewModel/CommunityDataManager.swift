//
//  CommunityDataManager.swift
//  ZANI
//
//  Created by 정도현 on 6/4/24.
//

import Combine
import Foundation

final class CommunityDataManager: ObservableObject {
  
  // MARK: Variables
  @Published var viewState: ViewState = .success
  
  public private(set) var articleList: ArticleListDTO? = nil
  public private(set) var errorMsg: String = ""
  
  // MARK: UseCases
  private var postUseCase: PostUseCaseImpl = PostUseCaseImpl(postRepository: DefaultPostRepository())
  
  public enum Action {
    case mainViewAppear
    case tappedWriting
  }
  
  public func action(_ action: Action) {
    switch action {
    case .mainViewAppear:
      self.fetchPost()
      
    default:
      return
    }
  }
}

private extension CommunityDataManager {

  func fetchPost() {
    postUseCase.read(page: 0, size: 10, keyword: "") { response in
      switch(response) {
      case .success(let data):
        if let data = data as? ArticleListDTO {
          self.articleList = data
          self.viewState = .success
        } else {
          self.viewState = .failure(errorDescription: "데이터 오류")
        }
        
      case .requestErr(let error):
        if let error = error as? ErrorModel {
          self.viewState = .failure(errorDescription: error.message)
        }
        
      default:
        self.viewState = .failure(errorDescription: "error")
      }
    }
  }
  
  func createPost(title: String, content: String) {
    postUseCase.create(title: title, content: content) { response in
      switch(response) {
      case .success:
        print("create Sucess!!")
        
      default:
        print("data fetch Error!!!")
      }
    }
  }
}
