import SDWebImage

class BlurhashLoader: NSObject, SDImageLoader {
  // MARK: - SDImageLoader

  func canRequestImage(for url: URL?) -> Bool {
    return url?.scheme == "blurhash"
  }

  func requestImage(
    with url: URL?,
    options: SDWebImageOptions = [],
    context: [SDWebImageContextOption: Any]?,
    progress progressBlock: SDImageLoaderProgressBlock?,
    completed completedBlock: SDImageLoaderCompletedBlock? = nil
  ) -> SDWebImageOperation? {
    guard let url = url else {

      completedBlock?(nil, nil, NSError(domain: "ThumHas", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL provided to ThumbhashLoader is missing" ]), false)
      return nil
    }

    // The URI looks like this: blurhash:/WgF}G?az0fs.x[jat7xFRjNHt6s.4;oe-:RkVtkCi^Nbo|xZRjWB
    // Which means that the `pathComponents[0]` is `/` and we need to skip it to get the hash.
    let blurhash = url.pathComponents[1]
    let size = CGSize(width: 16, height: 16)

    DispatchQueue.global(qos: .userInitiated).async {
      if let image = image(fromBlurhash: blurhash, size: size) {
        DispatchQueue.main.async {
          completedBlock?(UIImage(cgImage: image), nil, nil, true)
        }
      } else {
        completedBlock?(nil, nil, NSError(domain: "ThumHas", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to generate an image from the given blurhash" ]), false)
      }
    }
    return nil
  }

  func shouldBlockFailedURL(with url: URL, error: Error) -> Bool {
    // If the algorithm failed to generate an image from the url,
    // it's not possible that next time it will work :)
    return true
  }
}
