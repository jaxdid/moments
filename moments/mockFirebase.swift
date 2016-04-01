
import Foundation
import Firebase

class MockFirebase: Firebase {
  var authError:NSError? = NSError(domain: "User authentication", code: 1, userInfo: nil)
  var mockMoment: MockMoment!
  var mockMoments: [MockMoment] = []
  var current_user: MockMoment?
  var snapshot: Snapshot?
  
  override func observeEventType(eventType: FEventType, andPreviousSiblingKeyWithBlock block: ((FDataSnapshot!, String!) -> Void)!) -> UInt {
    block(snapshot, nil)
    return 1
  }
  
  override func childByAppendingPath(pathString: String!) -> Firebase! {
    return Firebase()
  }
  
  func createMockMoment(text: String!) {
    mockMoment = MockMoment(text: text)
    mockMoments += [mockMoment]
  }
  
  override func unauth() {
    current_user = nil
  }
}

class MockMoment: FMutableData{
  var text: String!
  init?(text: String) {
    super.init()
    self.text=text
  }
  
}

class Snapshot: FDataSnapshot {
  var FBref: MockFirebase!
  var data: AnyObject?
  
  init?(FBref: MockFirebase!, data: AnyObject?) {
    self.FBref = FBref
    if data is NSDictionary { self.data = data as! NSDictionary }
    else if data is NSArray { self.data = data as! NSArray }
    else if data is NSInteger { self.data = data as! NSInteger }
    else if data is NSString {
      print("This is a STRING")
      self.data = data as! NSString
    }
    else { self.data = nil }
  }
  
  override func childSnapshotForPath(childPathString: String!) -> FDataSnapshot! {
    return Snapshot(FBref: self.FBref, data: self.data![childPathString]) //as Snapshot!
  }
  
  override func hasChild(childPathString: String!) -> Bool {
    return (self.data != nil && self.data![childPathString] != nil)
  }
  
  override func hasChildren() -> Bool {
    return (childrenCount > 0)
  }
  
  override func exists() -> Bool {
    return (self.data != nil)
  }
  
  override var value: AnyObject! {
    get {
      print(self.data as? NSDictionary)
      return self.data
    }
  }
  
  override var childrenCount: UInt {
    get {
      return self.data != nil ? UInt(self.data!.count) : 0
    }
  }
  
  override var ref: Firebase! {
    get {
      return self.FBref
    }
  }
  
  override var key: String! {
    get {
      return "/"
    }
  }
  
  override var children: NSEnumerator! {
    get {
      if(hasChildren()) {
        let array:NSMutableArray = []
        let data = self.data as? NSDictionary
        
        data!.forEach { item in
          array.addObject(childSnapshotForPath(item.key as! String) as! Snapshot)
        }
        
        return (array as NSArray!).objectEnumerator()
      }
      else {
        return nil
      }
    }
  }
  
  override var priority: AnyObject! {
    get {
      return nil
    }
  }
}