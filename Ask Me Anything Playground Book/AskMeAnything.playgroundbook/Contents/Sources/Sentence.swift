import Foundation

struct Sentence {
    let words: [String]
    
    init(clause: String) {
        let preClause = clause.lowercased()
        words = Sentence.separateIntoWords(clause: preClause)
    }
    
    static private func separateIntoWords(clause: String) -> [String] {
        return clause.components(separatedBy: [" ", "?", ",", "."])
    }
}
