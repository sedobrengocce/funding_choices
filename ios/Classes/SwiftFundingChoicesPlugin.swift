import Flutter
import UIKit
import UserMessagingPlatform

public class SwiftFundingChoicesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
          let channel = FlutterMethodChannel(name: "funding_choices", binaryMessenger: registrar.messenger())
          let instance = SwiftFundingChoicesPlugin()
          registrar.addMethodCallDelegate(instance, channel: channel)
      }

      public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
          let arguments: [String: Any?] = call.arguments as! [String: Any?]
          switch call.method {
              case "init":
                  requestConsentInformation(tagForUnderAgeOfConsent: arguments["tagForUnderAgeOfConsent"] as! Bool, result: result)
              default:
                  result(FlutterMethodNotImplemented)
          }
      }

      /// Requests the consent information.
      private func requestConsentInformation(tagForUnderAgeOfConsent: Bool, result: @escaping FlutterResult) {
          let params = UMPRequestParameters()
          params.tagForUnderAgeOfConsent = tagForUnderAgeOfConsent

          UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: params) { error in
              if error == nil {
                  self.showConsentForm(result: result)
              } else {
                  result(FlutterError(code: "request_error", message: error!.localizedDescription, details: nil))
              }
          }
      }

      /// Shows the consent form.
      private func showConsentForm(result: @escaping FlutterResult) {
          let viewController = UIApplication.shared.keyWindow?.rootViewController
          if viewController == nil {
              result(FlutterError(code: "view_controller_error", message: "View controller is null.", details: nil))
              return
          }

          UMPConsentForm.load { form, error in
              if error == nil {
                  form!.present(from: viewController!) { dismissError in
                      if dismissError == nil {
                          result(true)
                      } else {
                          result(FlutterError(code: "form_dismiss_error", message: dismissError!.localizedDescription, details: nil))
                      }
                  }
              } else {
                  result(FlutterError(code: "form_error", message: error!.localizedDescription, details: nil))
              }
          }
      }
  }
