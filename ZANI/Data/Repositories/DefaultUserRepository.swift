//
//  DefaultUserRepository.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import Foundation
import Alamofire
import UIKit

final class DefaultUserRepository: BaseService, UserRepository {
 
  public func requestSocialSignUp(
    id: String,
    provider: AuthProvider,
    completion: @escaping (NetworkResult<Any>) -> (Void)
  ) {
    AFManager.request(AuthRouter.requestSocialSignUp(id: id, provider: provider)).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        
        let networkResult = self.judgeStatus(by: statusCode, data, type: SignUpDTO.self)
        
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  public func requestUserInfo(completion: @escaping (NetworkResult<Any>) -> (Void)) {
    AFManager.request(UserRouter.requestUserInfo).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        let networkResult = self.judgeStatus(by: statusCode, data, type: UserInfoDTO.self)
        
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  public func updateUserInfo(
    image: UIImage?,
    nickname: String?,
    completion: @escaping (NetworkResult<Any>) -> (Void)
  ) {
    AFManager.upload(
      multipartFormData: UserRouter.updateUserInfo(image: image, nickname: nickname).multipart,
      with: UserRouter.updateUserInfo(image: image, nickname: nickname)
    ).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        let networkResult = self.judgeStatus(by: statusCode, data, type: Bool.self)
        
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  public func requestNicknameDuplicate(nickname: String, completion: @escaping (NetworkResult<Any>) -> Void) {
    AFManager.request(
      MyPageRouter.checkNicknameDuplicate(nickname: nickname)
    ).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        let networkResult = self.judgeStatus(by: statusCode, data, type: Bool.self)
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  public func requestFollowList(completion: @escaping (NetworkResult<Any>) -> Void) {
    AFManager.request(
      FollowingRouter.requestFollowList
    ).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        let networkResult = self.judgeStatus(by: statusCode, data, type: [FollowDTO].self)
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  public func requestNightSummary(year: Int, month: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
    AFManager.request(
      AllNightersRouter.requestSummary(year: year, month: month)
    ).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        let networkResult = self.judgeStatus(by: statusCode, data, type: AllNightSummaryDTO.self)
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  public func requestAchievement(completion: @escaping (NetworkResult<Any>) -> Void) {
    AFManager.request(
      AchievementRouter.requestAchievement
    ).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        
        // TODO: Data Decoding
        do {
          let object = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
          print(object)
        } catch {
          print(error.localizedDescription)
        }
        
        // let networkResult = self.judgeStatus(by: statusCode, data, type: AllNightSummaryDTO.self)
        // completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
}
