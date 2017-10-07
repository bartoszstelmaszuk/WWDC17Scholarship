import Foundation

enum ConversationError: Error {
    case allDiscovered(String)
    case needHint(String)
}

class ConversationManager {
    
    let conversationDictionary: ConversationDictionary
    private var discoveredCategories = Set<ConversationDictionary.Category>()
    private var allDiscovered: Bool {
        var setCopy = discoveredCategories
        setCopy.remove(.unknown)
        return setCopy.count == conversationDictionary.conversationLookUpTable.count - 1
    }
    private var unknownQuestionsCounter: Int = 1
    private var unknownQuestionsLimit: Bool { return unknownQuestionsCounter % 3 == 0 ? true : false }
    
    init(conversationDictionary: ConversationDictionary) {
        self.conversationDictionary = conversationDictionary
    }
    
    func getAnswerFor(question: Sentence) throws -> (String, ConversationDictionary.Category) {
        guard allDiscovered == false else {
            throw ConversationError.allDiscovered(conversationDictionary.errorAnswer)
        }
        let category = conversationDictionary.assignCategoryTo(sentence: question)
        if category == .unknown {
            unknownQuestionsCounter += 1
            if unknownQuestionsLimit {
                throw ConversationError.needHint(conversationDictionary.hintAnswer)
            }
        }
        discoveredCategories.insert(category)
        return (conversationDictionary.assignAnswerTo(category: category) ?? conversationDictionary.errorAnswer,
                category)
    }
    
    func reset() {
        discoveredCategories.removeAll()
    }
}
