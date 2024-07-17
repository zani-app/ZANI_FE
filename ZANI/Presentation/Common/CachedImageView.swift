//
//  CachedImageView.swift
//  ZANI
//
//  Created by 정도현 on 7/7/24.
//

import SwiftUI

public struct CachedImageView: View {
  
  @State private(set) var uiImage: UIImage? = nil
  
  public let url: String
  public let imageSize: CGFloat
  
  public init(url: String, imageSize: CGFloat) {
    self.url = url
    self.imageSize = imageSize
  }
  
  public var body: some View {
    Group {
      if let uiImage = uiImage {
        Image(uiImage: uiImage)
          .resizable()
          .aspectRatio(contentMode: .fill)
      } else {
        ProgressView()
      }
    }
    .frame(height: imageSize)
    .clipShape(
      Circle()
    )
    .frame(width: imageSize, height: imageSize)
    .task {
      setImageUrl(url: url)
    }
  }
}

extension CachedImageView {
  private func setImageUrl(url: String) {
    DispatchQueue.global(qos: .background).async {
      let cacheKey = NSString(string: url)
      
      if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
        self.uiImage = cachedImage
        return
      }
      
      guard let url = URL(string: url) else { return }
      
      URLSession.shared.dataTask(with: url) { (data, result, error) in
        guard error == nil else {
          DispatchQueue.main.async {
            self.uiImage = UIImage()
          }
          return
        }
        
        DispatchQueue.main.async {
          if let data = data, let image = UIImage(data: data) {
            ImageCacheManager.shared.setObject(image, forKey: cacheKey)
            self.uiImage = image
          }
        }
      }.resume()
    }
  }
}

#Preview {
  CachedImageView(url: "", imageSize: 20)
}
