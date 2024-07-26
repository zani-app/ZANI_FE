//
//  CommunityDataManager.swift
//  ZANI
//
//  Created by 정도현 on 6/4/24.
//

import Combine
import Foundation
import UIKit

final class CommunityDataManager: ObservableObject {
  
  @Published public var pageController: CommunityPageManager = CommunityPageManager()
  
  // MARK: Variables
  @Published var viewState: ViewState = .success {
    didSet {
      switch viewState {
      case .failure(let errorDescription):
        self.errorMsg = errorDescription
        
      default:
        self.errorMsg = ""
      }
    }
  }
  
  private var selectedArticle: PostDTO? = nil
  public private(set) var postList: PostListDTO? = nil
  public private(set) var errorMsg: String = ""
  public private(set) var postDetail: PostDetailDTO? = nil
  
  // MARK: UseCases
  private var postUseCase: PostUseCaseImpl = PostUseCaseImpl(postRepository: DefaultPostRepository())
  
  public enum Action {
    
    // User Action
    case mainViewAppear
    case tappedCreateArticle
    case tappedWritingButton
    case tappedArticle(id: Int)
    case tappedBackButton
    
    // Inner Business Action
    case _moveBackPage
    case _moveWritingPage
    case _moveDetailPage
  }
  
  public func action(_ action: Action) {
    switch action {
    case .mainViewAppear:
      self.fetchPost()
      
    case .tappedWritingButton:
      self.action(._moveWritingPage)
      
    case .tappedCreateArticle:
      self.createPost(title: "test", content: "test")
      
    case let .tappedArticle(id: postId):
      self.detailPost(postId: postId)
      
    case .tappedBackButton:
      self.action(._moveBackPage)
      
    case ._moveBackPage:
      self.pageController.popToRoot()
      
    case ._moveWritingPage:
      self.pageController.push(.writing)
      
    case ._moveDetailPage:
      self.pageController.push(.detail)
      
    default:
      return
    }
  }
}

private extension CommunityDataManager {

  /// 커뮤니티 게시글을 가져옵니다.
  func fetchPost() {
    self.viewState = .loading
    
    postUseCase.read(page: 0, size: 10, keyword: "") { response in
      switch(response) {
      case .success(let data):
        if let data = data as? PostListDTO {
          self.postList = data
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
  
  /// 커뮤니티 게시글을 가져옵니다.
  func detailPost(postId: Int) {
    self.viewState = .loading
    
    postUseCase.readDetail(postId: postId) { response in
      switch(response) {
      case .success(let data):
        if let data = data as? PostDetailDTO {
          self.postDetail = data
          self.viewState = .success
          self.action(._moveDetailPage)
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
  
  /// 게시글을 생성합니다.
  func createPost(title: String, content: String) {
    self.viewState = .loading
    
//    var arr: [UIImage] = []
//    let uiImage = UIImage(systemName: "chevron.left")
//    arr.append(uiImage ?? UIImage())
    
    postUseCase.create(title: title, content: content, images: []) { response in
      switch(response) {
      case .success:
        self.viewState = .success
        self.action(._moveBackPage)
        
      case .requestErr(let error):
        if let error = error as? ErrorModel {
          self.viewState = .failure(errorDescription: error.message)
        }
        
      case .serverErr:
        self.viewState = .failure(errorDescription: "서버 내부 오류입니다.")
      
      default:
        self.viewState = .failure(errorDescription: "error")
      }
    }
  }
}
