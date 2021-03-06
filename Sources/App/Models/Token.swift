import Vapor
import Fluent

final class Token: Model {

    static let schema: String = "tokens"

    // MARK: Properties
    @ID()
    var id: UUID?

    @Field(key: FieldKeys.token.rawValue)
    var token: String

    @OptionalField(key: FieldKeys.expiresAt.rawValue)
    var expiresAt: Date?

    // MARK: Relations
    @Parent(key: FieldKeys.user.rawValue)
    var user: User

    // MARK: Initializer
    required init() {}

    init(id: Token.IDValue? = nil, userId: User.IDValue, token: String, expiresAt: Date? = nil) {
        self.id = id
        self.$user.id = userId
        self.token = token
        self.expiresAt = expiresAt
    }
}

// MARK: Field keys
extension Token {

    enum FieldKeys: FieldKey {
        case user = "user_id"
        case token
        case expiresAt = "expires_at"
    }
}

extension Token: ModelTokenAuthenticatable {

    static var valueKey = \Token.$token
    static let userKey = \Token.$user

    var isValid: Bool {
        guard let expiryDate = expiresAt else {
            return true
        }
        return expiryDate > Date()
    }
}

extension Token {

    private static let calender: Calendar = Calendar(identifier: .gregorian)

    convenience init(_ user: User) throws {
        self.init(
            id: nil,
            userId: try user.requireID(),
            token: [UInt8].random(count: 16).base64,
            expiresAt: Token.calender.date(byAdding: .year, value: 1, to: Date())
        )
    }
}
