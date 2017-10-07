import Foundation

struct ConversationDictionary {
    enum Category {
        case identity
        case university
        case work
        case achievements
        case funFact
        case hobby
        case dream
        case unknown
    }
    
    typealias ConversationLookUpTable = [Category: (keywords: [String], answer: String)]
    
    let conversationLookUpTable: ConversationLookUpTable
    let errorAnswer: String
    let hintAnswer: String
    
    init(conversationLookUpTable: ConversationLookUpTable, errorAnswer: String, hintAnswer: String) {
        self.conversationLookUpTable = conversationLookUpTable
        self.errorAnswer = errorAnswer
        self.hintAnswer = hintAnswer
    }
    
    func assignCategoryTo(sentence: Sentence) -> Category {
        for word in sentence.words {
            switch word.lowercased() {
            case _ where (conversationLookUpTable[.identity]?.keywords.contains { (element) -> Bool in
                return (word.range(of: element) != nil)
                })!:
                return .identity
            case _ where (conversationLookUpTable[.university]?.keywords.contains { (element) -> Bool in
                return (word.range(of: element) != nil)
                })!:
                return .university
            case _ where (conversationLookUpTable[.work]?.keywords.contains { (element) -> Bool in
                return (word.range(of: element) != nil)
                })!:
                return .work
            case _ where (conversationLookUpTable[.achievements]?.keywords.contains { (element) -> Bool in
                return (word.range(of: element) != nil)
                })!:
                return .achievements
            case _ where (conversationLookUpTable[.funFact]?.keywords.contains { (element) -> Bool in
                return (word.range(of: element) != nil)
                })!:
                return .funFact
            case _ where (conversationLookUpTable[.hobby]?.keywords.contains { (element) -> Bool in
                return (word.range(of: element) != nil)
                })!:
                return .hobby
            case _ where (conversationLookUpTable[.dream]?.keywords.contains { (element) -> Bool in
                return (word.range(of: element) != nil)
                })!:
                return .dream
            default: break
            }
        }
        return .unknown
    }
    
    func assignAnswerTo(category: Category) -> String? {
        switch category {
        case .identity:
            return conversationLookUpTable[category]?.answer
        case .university:
            return conversationLookUpTable[category]?.answer
        case .work:
            return conversationLookUpTable[category]?.answer
        case .achievements:
            return conversationLookUpTable[category]?.answer
        case .funFact:
            return conversationLookUpTable[category]?.answer
        case .hobby:
            return conversationLookUpTable[category]?.answer
        case .dream:
            return conversationLookUpTable[category]?.answer
        case .unknown:
            return conversationLookUpTable[category]?.answer
            
        }
    }
}
