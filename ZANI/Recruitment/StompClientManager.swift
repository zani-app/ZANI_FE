import Foundation
import Starscream
import SwiftUI

class StompClient: ObservableObject, WebSocketDelegate {
  
  var socket: WebSocket!
  
  let serverURL = URL(string: "wss://dongkyeom.com/ws-connection")!
  
  @Published var receivedMessages: [String] = []
  
  init() {
    var request = URLRequest(url: serverURL)
    request.timeoutInterval = 5
    socket = WebSocket(request: request)
    socket.delegate = self
    socket.connect()
  }
  
  func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
    switch event {
    case .connected(_):
      print("WebSocket is connected")
      // 연결 성공 후 CONNECT 프레임 전송
      connectStomp()
      
    case .text(let string):
      if string.contains("CONNECTED") {
        print("STOMP Connected")
        // CONNECTED 프레임 수신 후 구독 시작
        subscribe(to: "/subscribe/team/8")
        
      } else {
        print(string)
        
        guard let data = string.data(using: .utf8) else {
          print("Failed to convert JSON string to data")
          return
        }
        
        do {
          let decoder = JSONDecoder()
          let chgat = try? decoder.decode(Chat.self, from: data)
          print(chgat?.sendTime, "NIlnl")
        } catch {
          print("Error decoding JSON: \(error.localizedDescription)")
        }
        
        handleReceivedText(string)
      }
      
    default:
      break
    }
  }
  
  func connectStomp() {
    let connectFrame = "CONNECT\naccept-version:1.1,1.0\n\n\u{00}"
    socket.write(string: connectFrame)
  }
  
  func subscribe(to destination: String) {
    let subscribeFrame = "SUBSCRIBE\nid:sub-0\ndestination:\(destination)\n\n\u{00}"
    socket.write(string: subscribeFrame)
  }
  
  func sendMessage(from nickname: String, to destination: String, with body: String) {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds, .withTimeZone]
    
    let now = Date()
    let dateString = dateFormatter.string(from: now)
    
    let messageData: [String: Any] = [
      "type": "messageType",
      "content": body,
      "sendTime": dateString,
      "sender": nickname
    ]
    
    if let jsonDAta = try? JSONSerialization.data(withJSONObject: messageData, options: []) {
      if let jsonString = String(data: jsonDAta, encoding: .utf8) {
        let sendFrame = "SEND\ndestination:\(destination)\ncontent-type:application/json\n\n\(jsonString)\u{00}"
        socket.write(string: sendFrame)
      }
    }
    
  }
  
  func handleReceivedText(_ text: String) {
    DispatchQueue.main.async {
      self.receivedMessages.append(text)
    }
  }
}
