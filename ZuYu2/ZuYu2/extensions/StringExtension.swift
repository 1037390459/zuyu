//
//  StringExtension.swift
//  ZuYu2
//
//  Created by million on 2020/9/13.
//  Copyright © 2020 million. All rights reserved.
//

import Foundation
import CryptoSwift

extension String {

    func aesEncrypt(key: String, iv: String) throws -> String {
        var result = ""
        do {
            let mIv =  iv.utf8.map { UInt8($0.byteSwapped) }
            let key: [UInt8] = Array(key.utf8) as [UInt8]
            let aes = try! AES(key: key, blockMode: CBC(iv: mIv), padding: .pkcs5) // AES128 .CBC pkcs7
            let encrypted = try aes.encrypt(Array(self.utf8))

            result = encrypted.toBase64()!

            print("AES Encryption Result: \(result)")

        } catch {
            print("Error: \(error)")
        }

        return result
    }

    func aesDecrypt(key: String) throws -> String {
        var result = ""
        do {
            let encrypted = self
            let key: [UInt8] = Array(key.utf8) as [UInt8]
            let aes = try! AES(key: key, blockMode: ECB(), padding: .pkcs5) // AES128 .ECB pkcs7
            let decrypted = try aes.decrypt(Array(base64: encrypted))

            result = String(data: Data(decrypted), encoding: .utf8) ?? ""

            print("AES Decryption Result: \(result)")

        } catch {

            print("Error: \(error)")
        }

        return result
    }
}
