import PlaygroundSupport
import UIKit

extension UINavigationController: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case let .string(text):
            if let vc = topViewController as? ChatViewController {
                vc.ask(question: text)
            }
        default:
            print("wrong input")
        }
    }
}

let vc = ChatViewController()

PlaygroundPage.current.liveView = UINavigationController(rootViewController: vc)
