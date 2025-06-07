import Flutter
import UIKit

public class FlutterNativeOcrPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "flutter_native_ocr", binaryMessenger: registrar.messenger())
    let instance = FlutterNativeOcrPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "recognizeText":
      guard let args = call.arguments as? [String: Any],
        let imagePath = args["imagePath"] as? String
      else {
        result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing imagePath", details: nil))
        return
      }
      OCRHelper.recognizeText(from: imagePath) { text in
        DispatchQueue.main.async {
          result(text)
        }
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
