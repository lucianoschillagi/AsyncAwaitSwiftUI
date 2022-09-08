
import Foundation

// Ref: https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html#ID515
func canThrowAnError() throws {
    // this function may or may not throw an error
}

do {
    try canThrowAnError()
    // no error was thrown
} catch {
    // an error was thrown
}


var errorLabel = "" // shows the error description to the user (feedback)

// Error Protocol: A type representing an error value that can be thrown.
enum ValidationError: Error {
    case tooShort
    case tooLong
    case invalidCharacterFound(Character)
    case invalidWhiteSpaceFound(Character) // TODO
}

extension ValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .tooShort:
            return NSLocalizedString(
                "❌ Your username needs to be at least 4 characters long",
                comment: ""
            )
        case .tooLong:
            return NSLocalizedString(
                "❌ Your username can't be longer than 14 characters",
                comment: ""
            )
        case .invalidCharacterFound(let character):
            let format = NSLocalizedString(
                "❌ Your username can't contain the character '%@'",
                comment: ""
            )
            return String(format: format, String(character))

        case .invalidWhiteSpaceFound(let character):
            let format = NSLocalizedString(
                "❌ Invalid whitespace found",
                comment: ""
            )
            return String(format: format, String(character))

        }
    }
}

func validate(username: String) throws {
    
    // Error Condition 1
    guard username.count > 3 else {
        // if "username" has 2 or fewer characters, throw an error
        throw ValidationError.tooShort
    }
    
    // Error Condition 2
    guard username.count < 15 else {
        // if "username" has 15 or more characters, throw an error
        throw ValidationError.tooLong
    }
    
    // Error Condition 3
    for character in username {
        guard character.isLetter else {
            // "username" will only accept characters
            throw ValidationError.invalidCharacterFound(character)
        }
    }
    
    // TODO: Error Condition 4, whitespaces
    
    // OK Condition
    if username.count > 3 && username.count < 15 {
        print("✅ OK")
    }
}

func userDidPickName(_ username: String) {
    do {
        try validate(username: username) // "validate" func can throw an error
    } catch {
        errorLabel = error.localizedDescription
    }
}

// TODO: async func version of 'userDidPickName(uesrname: String)'

userDidPickName("somename") // the user can insert a legal value or ilegal value
print(errorLabel)


