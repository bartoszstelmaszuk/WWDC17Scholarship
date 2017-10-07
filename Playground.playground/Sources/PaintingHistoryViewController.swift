import Foundation
import UIKit

class PaintingHistoryViewController: UIViewController, UIScrollViewDelegate {
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Painting's History"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let detailedViewConfiguration = DetailedInformationConfiguration(
            text: "Stańczyk, the male figure depicted in the painting, was the court jester when Poland was at the height of its political, economic and cultural power during the era of the Renaissance in Poland. Besides his fame as a jester he has been described as an eloquent, witty, and intelligent man, using satire to comment on the nation's past, present, and future. Unlike jesters of other European courts, Stańczyk has always been considered as much more than a mere entertainer. Stańczyk's fame and legend were strong in his own time and enjoyed a resurgence in the 19th century, and he remains well-known to this day.",
            image: UIImage(named: "Jan_Matejko_Stanczyk.jpg")!,
            showCloseButton: false
        )
        let detailedView = DetailedInformationScrollView(frame: UIScreen.main.bounds, configuration: detailedViewConfiguration)
        view = detailedView
        detailedView.delegate = self
    }
    
    override func viewDidLoad() {
        let close = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.closeVC))
        navigationItem.leftBarButtonItem = close
    }
    
    @objc private func closeVC() {
        dismiss(animated: true, completion: nil)
    }
}
