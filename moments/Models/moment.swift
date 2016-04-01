import Foundation

class Moment {
  func build(momoji: String, text: String, latitude: Double, longitude: Double, userName: String, uid: String, timestamp: String, imageKey: String) -> NSDictionary {
    return ["momoji": momoji,
            "text": text,
            "latitude": latitude,
            "longitude": longitude,
            "userName": userName,
            "userId": uid,
            "timestamp": timestamp,
            "imageKey": imageKey]
  }
}