//
//  ChatDTO.swift
//  ZANI
//
//  Created by 정도현 on 3/24/24.
//

import Foundation
import SwiftUI

public struct ChatDTO: Codable, Hashable {
  let messageList: [Chat]
  let hasNext: Bool
}

public struct Chat: Codable, Hashable {
  let type: String
  let senderNickname: String
  let senderProfileImage: String
  let content: String
  let sendTime: String
}
