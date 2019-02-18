// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Back
  internal static let back = L10n.tr("Localizable", "Back")
  /// Hello!
  internal static let hello = L10n.tr("Localizable", "Hello")
  /// Login
  internal static let login = L10n.tr("Localizable", "Login")
  /// More
  internal static let moreTabBarItem = L10n.tr("Localizable", "More_TabBarItem")
  /// Sign up a new account
  internal static let signUpANewAccount = L10n.tr("Localizable", "Sign up a new account")
  /// %1$@ - tab - %2$i of %3$i
  internal static func tabBarItemAccessibilityLabel(_ p1: String, _ p2: Int, _ p3: Int) -> String {
    return L10n.tr("Localizable", "TabBarItem_AccessibilityLabel", p1, p2, p3)
  }
  /// Selected - %1$@ - tab - %2$i of %3$i
  internal static func tabBarItemSelectedAccessibilityLabel(_ p1: String, _ p2: Int, _ p3: Int) -> String {
    return L10n.tr("Localizable", "TabBarItem_Selected_AccessibilityLabel", p1, p2, p3)
  }
  /// Welcome
  internal static let welcome = L10n.tr("Localizable", "Welcome")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
