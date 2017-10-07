import Foundation
import UIKit
import PlaygroundSupport

public class ChatViewController: UIViewController {
    
    private let conversationManager: ConversationManager
    private let detailedViewConfigurations: [ConversationDictionary.Category : DetailedInformationConfiguration] = [
        .identity : DetailedInformationConfiguration(
            text: "I'm married to beautiful wife, a father to an amazing son, a programmer in a great company and a student of the best technical university in Poland! I regard myself as a technical guy but between household duties and playing with my son, I like listening to music.",
            image: UIImage(named: "family.jpg")!,
            showCloseButton: true
        ),
        .university : DetailedInformationConfiguration(
            text: "I received my Bachelor of Science degree dealing with Aerospace Engineering. It was at that time, when I first discovered the magic of programming while doing simulations of fluid and software to rotorcraft simulator. Now I'm doing my Master's degree at Warsaw University of Technology, where I'm studying Computer Science.",
            image: UIImage(named: "politechnika.jpg")!,
            showCloseButton: true
        ),
        .work : DetailedInformationConfiguration(
            text: "My first job around iOS was a summer internship. Fortunately, the world of iOS won my hearth and mind so just after the end of the semester I got my first real job in Polidea. I have been working here for more than a year now and during that time I've certainly gained a lot of experience, while having fun and the pleasure of cooperating with some of the best experts in this industry.",
            image: UIImage(named: "polidea.png")!,
            showCloseButton: true
        ),
        .achievements : DetailedInformationConfiguration(
            text: "Aside from starting a family, my biggest achievement was to obtain Bachelor's degree, which was even awarded with a golden clip from the faculty (you can see it on the picture) and transfer to a totally different field of studies. Next big thing in my life was getting my dream job at Polidea, where I can learn about Swift -  one of the fastest and most promising programming language - every day.",
            image: UIImage(named: "meil.jpg")!,
            showCloseButton: true
        ),
        .funFact : DetailedInformationConfiguration(
            text: "I've always taken life as it is and was never afraid to experience new things. One day I even decided to learn how to walk on stilts!  As you can see on the picture no only did I manage to do it, but I also made quite a performance, dressed like an angel after the wedding ceremony. Kids went crazy!",
            image: UIImage(named: "stilts.jpg")!,
            showCloseButton: true
        )
    ]
    
    private var currentQuestionCategory: ConversationDictionary.Category? = nil
    
    private var castView: ChatView {
        guard let view = view as? ChatView else {
            fatalError()
        }
        return view
    }
    
    public init() {
        let conversationDictionary = ConversationDictionary(
            conversationLookUpTable: [
                .identity : (
                    ["age", "old", "name", "surname", "identity", "student"],
                    "My name is Bartosz Stelmaszuk and I'm 25 years old"
                ),
                .university : (
                    ["university", "school", "learn", "education", "study"],
                    "I study at Warsaw University of Technology"
                ),
                .work : (
                    ["work", "job", "profession"],
                    "I work as a Software Engineer in Polidea"
                ),
                .achievements : (
                    ["achieve", "success", "glory"],
                    "Bachelor's degree in Aerospace Engineering"
                ),
                .funFact : (
                    ["fun", "crazy", "craziest", "unusual", "fact"],
                    "I did some crazy things in my life..."
                ),
                .dream : (
                    ["dream", "wonder", "wwdc"],
                    "Currently my dream is to get on WWDC17, but my long-term goal is to look at my life as an old man and say: \"I've lived a good life\""
                ),
                .hobby : (
                    ["hobby", "piano", "love", "coding", "interest", "free", "spare", "slack", "time"],
                    "I love playing piano and coding. Surprisingly, I think these two have a lot in common!"
                ),
                .unknown : (
                    [],
                    "I don't get it. Can you ask your question differently?"
                )
            ],
            errorAnswer: "There's nothing more to say. Now we just have to meet in person at WWDC!",
            hintAnswer: "I don't have an answer for that. Try to check questions' categories under the HINT button"
        )
        conversationManager = ConversationManager(conversationDictionary: conversationDictionary)
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func loadView() {
        super.loadView()
        view = ChatView(actionHandler: { [weak self] action in self?.handle(action: action) })
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func handle(action: ChatViewAction) {
        switch action {
        case .didTapBubble:
            transitionToView()
        case .showPainterInfo:
            showPainterInfo()
        }
    }
    
    public func ask(question: String) {
        do {
            let sentence = Sentence(clause: question)
            let (answer, category) = try conversationManager.getAnswerFor(question: sentence)
            currentQuestionCategory = category
            switch category {
            case .unknown, .dream, .hobby:
                castView.showMessage(message: answer, isHiddenMoreButton: true)
            default:
                castView.showMessage(message: answer)
            }
        } catch ConversationError.allDiscovered(let answer) {
            castView.showMessage(message: answer, isHiddenMoreButton: true)
        } catch ConversationError.needHint(let answer) {
            castView.showMessage(message: answer, isHiddenMoreButton: true)
        } catch {
            return
        }
    }
    
    private func transitionToView() {
        guard let currentCategory = currentQuestionCategory,
            let detailedViewConfiguration = detailedViewConfigurations[currentCategory] else { return }
        currentQuestionCategory = nil
        castView.transitionTo(detailedViewConfiguration: detailedViewConfiguration)
    }

    private func showPainterInfo() {
        let vc = PaintingHistoryViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navigationController?.present(navVC, animated: true, completion: nil)
    }
}
