//
//  ImageCacheManager.swift
//  ZANI
//
//  Created by 정도현 on 7/7/24.
//

import Foundation
import SwiftUI

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
