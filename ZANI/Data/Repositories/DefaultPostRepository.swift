//
//  DefaultPostRepository.swift
//  ZANI
//
//  Created by 정도현 on 6/4/24.
//

import Alamofire
import Foundation

final class DefaultPostRepository: BaseService, PostRepository {
  func requestPost(
    page: Int,
    size: Int,
    keyword: String,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    AFManager.request(
      PostRouter.requestPost(page: page, size: size, keyword: keyword)
    ).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        
        // TODO: DTO Setting
        let networkResult = self.judgeStatus(by: statusCode, data, type: TeamListDTO.self)
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  func createPost(
    title: String,
    content: String,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    AFManager.request(
      PostRouter.createPost(title: title, content: content)
    ).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        
        // TODO: Error 검사 - 서버 수정 필요
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
          print(json, "createPost")
        } else {
          print("Failed to convert data to JSON")
        }
        
        // TODO: DTO Setting
        let networkResult = self.judgeStatus(by: statusCode, data, type: Bool.self)
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  func patchPost(postId: Int, title: String, content: String, completion: @escaping (NetworkResult<Any>) -> Void) {
    AFManager.request(
      PostRouter.updatePost(postId: postId, title: title, content: content)
    ).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        
        // TODO: DTO Setting
        let networkResult = self.judgeStatus(by: statusCode, data, type: TeamListDTO.self)
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  func deletePost(postId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
    AFManager.request(
      PostRouter.deletePost(postId: postId)
    ).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        
        // TODO: DTO Setting
        let networkResult = self.judgeStatus(by: statusCode, data, type: TeamListDTO.self)
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
}
