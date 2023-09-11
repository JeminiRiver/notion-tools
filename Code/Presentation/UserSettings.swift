//
// UserSettings
// MacDial
//
// Created by Alex Babaev on 28 January 2022.
//
// Based on Andreas Karlsson sources
// https://github.com/andreasjhkarlsson/mac-dial
//
// License: MIT
//

import Foundation

extension SettingsValueKey {
   	
    static let sync: SettingsValueKey = "settings.sync"
}

class UserSettings {

	enum Sync {
        case one
        case two
    }

	@FromUserDefaults(key: .sync, defaultValue: 1)
    private var syncSetting: Int

    var sync: Sync {
        get {
            switch syncSetting {
                case 1: return .one
                case 2: return .two
                default: return .one
            }
        }
        set {
            switch newValue {
                case .one: syncSetting = 1
                case .two: syncSetting = 2
            }
        }
    }

}

struct SettingsValueKey: ExpressibleByStringLiteral {
    var name: String

    init(stringLiteral value: StringLiteralType) {
        name = value
    }
}

@propertyWrapper
struct FromUserDefaults<Value> {
    private let key: String
    private let defaultValue: Value
    private let userDefaults: UserDefaults

    init(key: SettingsValueKey, userDefaults: UserDefaults = UserDefaults.standard, defaultValue: Value) {
        self.key = key.name
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }

    var wrappedValue: Value {
        get {
            userDefaults.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }
}
