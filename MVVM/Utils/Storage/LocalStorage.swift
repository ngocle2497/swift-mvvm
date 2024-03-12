//
//  LocalStorage.swift
//  MVVM
//
//  Created by Ngoc H. Le on 11/03/2024.
//

import Foundation
import MMKV

struct LocalStorage {
    static var shared = LocalStorage()
    private var instance: MMKV?
    
    var appToken: String? {
        get {
            return instance?.string(forKey: "appToken")
        }
        set {
            if let value = newValue {
                instance?.set(value, forKey: "appToken")
            } else {
                instance?.removeValue(forKey: "appToken")
            }
            
        }
    }
    
    var appTheme: ColorTheme? {
        get {
            guard let theme =  instance?.string(forKey: "appTheme") else {
                return .dark
            }
            guard let themeKey = ColorTheme(rawValue: theme) else {
                return .dark
            }
            return themeKey
        }
        set {
            if let value = newValue {
                instance?.set(value.rawValue, forKey: "appTheme")
            } else {
                instance?.removeValue(forKey: "appTheme")
            }
        }
    }
    
    var appFont: FontSize? {
        get {
            guard let font =  instance?.string(forKey: "appFont") else {
                return .default
            }
            guard let fontKey = FontSize(rawValue: font) else {
                return .large
            }
            return fontKey
        }
        set {
            if let value = newValue {
                instance?.set(value.rawValue, forKey: "appFont")
            } else {
                instance?.removeValue(forKey: "appFont")
            }
        }
    }
    
    private init() {
        MMKV.initialize(rootDir: nil)
        self.instance = MMKV(mmapID: "LocalStorage", cryptKey: "ABCB".data(using: .utf8), mode: .singleProcess)
    }
    
    
}
