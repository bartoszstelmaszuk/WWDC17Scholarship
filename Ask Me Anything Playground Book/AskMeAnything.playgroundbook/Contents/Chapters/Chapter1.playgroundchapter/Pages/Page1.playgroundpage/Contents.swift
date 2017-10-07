/*:
 Meet this **chatbot** inspired by the popular Polish painting.
 
 To ask a question you have to fill the `String` argument of below provided function *ask()*.
 
 Can't wait to see you in action! Good luck in this "investigation" 👍
 
 Always rememeber that you can get help with question categories under the **hint** button!
 */
//#-hidden-code
import PlaygroundSupport

func ask(_ message: String) {
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        proxy.send(.string(message))
    }
}

//#-end-hidden-code

ask(/*#-editable-code */"<#What's your name?#>"/*#-end-editable-code*/)
