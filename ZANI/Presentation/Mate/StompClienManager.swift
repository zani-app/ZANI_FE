//
//  StompClientManager.swift
//  ZANI
//
//  Created by 정도현 on 3/24/24.
//

import Foundation
import SwiftStomp

final class StompClientManager: ObservableObject {
  // Socket Client instance
  static let shared = StompClientManager() // 싱글톤으로 사용하기 위함.
  
  private var swiftStomp: SwiftStomp?
  
  func setupWebSocket() {
    let url = URL(string: "wss://dongkyeom.com/ws-connection")!
            
    self.swiftStomp = SwiftStomp(host: url) //< Create instance
    self.swiftStomp?.connect()
    swiftStomp?.subscribe(to: "/app/greeting", mode: .clientIndividual)
  }
  
  
  func sendMessage() {
    swiftStomp?.send(body: "This is message's text body", to: "/app/greeting", receiptId: "msg-\(Int.random(in: 0..<1000))", headers: [:])
  }
}
