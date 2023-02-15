//
//  TiFreshchatModule.swift
//  titanium-freshchat
//
//  Created by Hans Knöchel
//  Copyright (c) 2022 Hans Knöchel. All rights reserved.
//

import FreshchatSDK
import UIKit
import TitaniumKit

@objc(TiFreshchatModule)
class TiFreshchatModule: TiModule {

  public let testProperty: String = "Hello World"
  
  func moduleGUID() -> String {
    return "3ff52391-b61c-4b8f-859c-e44bff8dbac1"
  }
  
  override func moduleId() -> String! {
    return "ti.freshchat"
  }
  
  override func _configure() {
    super._configure()
    TiApp.sharedApp().registerApplicationDelegate(self)
  }
  
  override func _destroy() {
    super._destroy()
    TiApp.sharedApp().unregisterApplicationDelegate(self)
  }

  @objc(initialize:)
  func initialize(args: [Any]) {
    guard let params = args.first as? [String: String] else { fatalError("Missing parameters") }
    
    let appId = params["appId"]
    let appKey = params["appKey"]
    let domain = params["domain"]
    let stringsBundle = params["stringsBundle"]

    guard let appId, let appKey else {
      fatalError("appId or appKey is not set")
    }

    let config = FreshchatConfig.init(appID: appId, andAppKey: appKey)
    if let domain {
      config.domain = domain
    }

    if let stringsBundle {
      config.stringsBundle = stringsBundle
    }
    
    Freshchat.sharedInstance().initWith(config)
    
    // To listen to restore id generated event:
    // Register for local notification
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(userRestoreIdReceived),
                                           name: NSNotification.Name(rawValue: FRESHCHAT_USER_RESTORE_ID_GENERATED),
                                           object: nil)
  }
  
  @objc(identifyUser:)
  func identifyUser(args: [Any]) {
    guard let externalId = args.first as? String else { fatalError("Missing parameters") }

    Freshchat.sharedInstance().identifyUser(withExternalID: externalId, restoreID: nil)
  }
  
  @objc(signInUser:)
  func signInUser(args: [Any]) {
    guard let params = args.first as? [String: String] else { fatalError("Missing parameters") }

    // Create a user object
    let user = FreshchatUser.sharedInstance();
    
    if let firstName = params["firstName"] {
      // To set an identifiable first name for the user
      user.firstName = firstName
    }
    
    if let lastName = params["lastName"] {
      // To set an identifiable last name for the user
      user.lastName = lastName
    }
    
    if let email = params["email"] {
      // To set user's email
      user.email = email
    }
  
    Freshchat.sharedInstance().setUser(user)
  }
  
  @objc(getRestoreID:)
  func getRestoreID(unused: [Any]?) -> String? {
    return FreshchatUser.sharedInstance().restoreID
  }

  @objc(updateUserProperty:)
  func updateUserProperty(args: [Any]) {
    guard let key = args.first as? String, let value = args.last as? String else { fatalError("Missing parameters") }

    Freshchat.sharedInstance().setUserPropertyforKey(key, withValue: value)
  }

  @objc(signOutUser:)
  func signOutUser(args: [Any]) {
    Freshchat.sharedInstance().resetUser()
  }

  @objc(trackEvent:)
  func trackEvent(args: [Any]) {
    guard let eventName = args.first as? String else { fatalError("Missing parameters") }
    
    Freshchat.sharedInstance().trackEvent(eventName, withProperties: args.last as? [String: Any] ?? [:])
  }

  @objc(showConversations:)
  func showConversations(args: [Any]?) {
    let controller = TiApp.sharedApp().controller.topPresentedController()

    if let message = args?.first as? String {
      let options = ConversationOptions()
      options.setTopicName(message, withReferenceID: UUID().uuidString)
      Freshchat.sharedInstance().showConversations(controller!, with: ConversationOptions())
    } else {
      Freshchat.sharedInstance().showConversations(controller!)

    }
  }
  
  @objc private func userRestoreIdReceived() {
    fireEvent("userRestoreIdReceived", with: [
      "restoreID": FreshchatUser.sharedInstance().restoreID ?? "",
      "externalID": FreshchatUser.sharedInstance().externalID ?? ""
    ])
  }
}

// MARK: UIApplicationDelegate

extension TiFreshchatModule : UIApplicationDelegate {
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Freshchat.sharedInstance().setPushRegistrationToken(deviceToken)
  }
}
