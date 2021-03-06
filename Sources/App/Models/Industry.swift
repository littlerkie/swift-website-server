import Vapor
import Fluent

final class Industry: Model {

    typealias IDValue = UUID

    static var schema: String = "industries"

    @ID()
    var id: IDValue?

    @Field(key: FieldKeys.title.rawValue)
    var title: String

    @Siblings(through: ExpIndustrySiblings.self, from: \.$industry, to: \.$experience)
    var experience: [Experience]

    init() {}

    init(title: String) {
        self.title = title
    }
}

// MARK: FieldKeys
extension Industry {

    enum FieldKeys: FieldKey {
        case title
    }
}

extension Industry: Serializing {
    typealias SerializedObject = Coding

    struct Coding: Content, Equatable {
        // `id` should not be nil except for creation action.
        var id: IDValue?

        // `title` can be nil except create & update new industry.
        var title: String?
    }

    convenience init(content: SerializedObject) throws {
        self.init(title: content.title ?? "")
        id = content.id
    }

    func reverted() throws -> SerializedObject {
        try SerializedObject.init(id: requireID(), title: title)
    }
}

extension Industry: Mergeable {

    func merge(_ other: Industry) {
        title = other.title
    }
}
