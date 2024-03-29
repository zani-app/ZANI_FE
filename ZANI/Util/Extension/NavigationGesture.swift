//
//  NavigationGesture.swift
//  ZANI
//
//  Created by 정도현 on 3/29/24.
//

import UIKit

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
  override open func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }
  
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}
