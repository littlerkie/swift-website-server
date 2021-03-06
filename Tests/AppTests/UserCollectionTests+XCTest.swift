import XCTest

///
/// NOTE: This file was generated by generate_linux_tests.rb
///
/// Do NOT edit this file directly as it will be regenerated automatically when needed.
///

extension UserCollectionTests {

   @available(*, deprecated, message: "not actually deprecated. Just deprecated to allow deprecated tests (which test deprecated functionality) without warnings")
   static var allTests : [(String, (UserCollectionTests) -> () throws -> Void)] {
      return [
                ("testAuthorizeRequire", testAuthorizeRequire),
                ("testCreateWithInvalidPayload", testCreateWithInvalidPayload),
                ("testCreateWithInvalidPassword", testCreateWithInvalidPassword),
                ("testCreateWithConflictUsername", testCreateWithConflictUsername),
                ("testCreate", testCreate),
                ("testQueryWithUserIDThatDoesNotExsit", testQueryWithUserIDThatDoesNotExsit),
                ("testQueryWithUserID", testQueryWithUserID),
                ("testQueryWithUserIDAndQueryParameters", testQueryWithUserIDAndQueryParameters),
                ("testQueryWithUserIDAndQueryParametersAfterAddChildrens", testQueryWithUserIDAndQueryParametersAfterAddChildrens),
                ("testQueryAll", testQueryAll),
                ("testQueryAllWithQueryParametersAfterAddChildrens", testQueryAllWithQueryParametersAfterAddChildrens),
                ("testUpdate", testUpdate),
                ("testQueryBlogThatAssociatedWithSpecialUser", testQueryBlogThatAssociatedWithSpecialUser),
           ]
   }
}

