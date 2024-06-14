//
//  CommunityDataManager.swift
//  ZANI
//
//  Created by 정도현 on 6/4/24.
//

import Combine
import Foundation

final class CommunityDataManager: ObservableObject {
  
  @Published private(set) var isSuccessTask: Bool = false
  
  private var postUseCase: PostUseCaseImpl = PostUseCaseImpl(postRepository: DefaultPostRepository())
}

extension CommunityDataManager {

  public func fetchPost() {
    postUseCase.read(page: 0, size: 10, keyword: "") { response in
      switch(response) {
      case .success:
        print("good!")
        
      default:
        print("data fetch Error")
      }
    }
  }
  
  public func createPost(title: String, content: String) {
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
