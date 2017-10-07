import PlaygroundSupport
import UIKit

class ChatNavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let vc = ChatViewController()
let navigationController = ChatNavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = navigationController

if let vc = navigationController.topViewController as? ChatViewController {
    vc.ask(question: "name")
}
