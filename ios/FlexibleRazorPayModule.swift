import Foundation
import Razorpay
import React

@objc(FlexibleRazorPayModule)
class FlexibleRazorPayModule: RCTEventEmitter, RazorpayPaymentCompletionProtocolWithData {

  private var razorpay: RazorpayCheckout?
  private var currentResolve: RCTPromiseResolveBlock?
  private var currentReject: RCTPromiseRejectBlock?

  // MARK: - RCTEventEmitter

  override static func requiresMainQueueSetup() -> Bool {
    return true
  }

  override func supportedEvents() -> [String]! {
    // If you want to emit events, list them here.
    // For now we only use promises, so leave it empty.
    return []
  }

  // MARK: - Exported Methods to JS

  /// JS: FlexibleRazorPayModule.open(options)
  @objc(open:resolver:rejecter:)
  func open(_ options: NSDictionary,
            resolver resolve: @escaping RCTPromiseResolveBlock,
            rejecter reject: @escaping RCTPromiseRejectBlock) {

    self.currentResolve = resolve
    self.currentReject = reject

    guard let key = options["key"] as? String else {
      reject("E_NO_KEY", "Key is required", nil)
      return
    }

    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }

      self.razorpay = RazorpayCheckout.initWithKey(key, andDelegateWithData: self)

      guard
        let window = UIApplication.shared.windows.first,
        let rootVC = window.rootViewController
      else {
        reject("E_NO_VC", "Could not get root view controller", nil)
        return
      }

      self.razorpay?.open(options as! [String: Any], displayController: rootVC)
    }
  }

  // MARK: - Razorpay Delegate

  func onPaymentError(_ code: Int32,
                      description str: String,
                      andData response: [AnyHashable : Any]?) {

    var userInfo: [String: Any] = [:]
    response?.forEach { key, value in
      if let key = key as? String {
        userInfo[key] = value
      }
    }
    userInfo["code"] = code
    userInfo["description"] = str

    currentReject?("E_PAYMENT_ERROR", str, NSError(domain: "FlexibleRazorPay", code: Int(code), userInfo: userInfo))
    currentResolve = nil
    currentReject = nil
  }

  func onPaymentSuccess(_ payment_id: String,
                        andData response: [AnyHashable : Any]?) {

    var result: [String: Any] = [:]
    response?.forEach { key, value in
      if let key = key as? String {
        result[key] = value
      }
    }
    result["razorpay_payment_id"] = payment_id

    currentResolve?(result)
    currentResolve = nil
    currentReject = nil
  }
}
