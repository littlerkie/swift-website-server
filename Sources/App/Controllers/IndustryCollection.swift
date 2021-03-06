import Vapor
import FluentMySQLDriver

class IndustryCollection: RestfulApiCollection {
    typealias T = Industry

    func performUpdate(_ original: T?, on req: Request) throws -> EventLoopFuture<T.Coding> {
        let coding = try req.content.decode(T.SerializedObject.self)
        guard coding.title != nil else {
            throw Abort.init(.unprocessableEntity, reason: "Value required for key 'industry.title'")
        }

        var industry = try T.init(content: coding)

        if let original = original {
            original.merge(industry)
            industry = original
        }

        return industry.save(on: req.db)
            .flatMapErrorThrowing({
                if case MySQLError.duplicateEntry(let localizedErrorDescription) = $0 {
                    throw Abort.init(.unprocessableEntity, reason: localizedErrorDescription)
                }
                throw $0
            })
            .flatMapThrowing({
                try industry.reverted()
            })
    }
}
