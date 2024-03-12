// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum S10n {
  /// Some alert body there
  internal static var alertMessage: String { return S10n.tr("Localizable", "alert_message", fallback: "Some alert body there") }
  /// Title for an alert
  internal static var alertTitle: String { return S10n.tr("Localizable", "alert_title", fallback: "Title of the alert") }
  internal enum Bananas {
    /// A comment with no space above it
    internal static func owner(_ p1: Int, _ p2: Any) -> String {
      return S10n.tr("Localizable", "bananas.owner", p1, String(describing: p2), fallback: "Those %d bananas belong to %@.")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension S10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = localized(key, table, value)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
