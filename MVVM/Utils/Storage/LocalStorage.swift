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
    
    var appToken: String {
        get {
            return instance?.string(forKey: "appToken") ?? ""
        }
        set {
            instance?.set(newValue, forKey: "appToken")
        }
    }
    
    private init() {
        MMKV.initialize(rootDir: nil)
        self.instance = MMKV(mmapID: "LocalStorage", cryptKey: "ABCB".data(using: .utf8), mode: .singleProcess)
    }
    
    
}
