//
//  Character.swift
//  AOC
//
//  Created by Dave DeLong on 12/4/18.
//  Copyright © 2018 Dave DeLong. All rights reserved.
//

import Foundation

public extension Character {
  static let alphabet = Array("abcdefghijklmnopqrstuvwxyz")
    
  init?(ascii: Int) {
    guard let scalar = Unicode.Scalar(ascii) else { return nil }
    self.init(scalar)
  }
    
  var isWhitespaceOrNewline: Bool { isWhitespace || isNewline }
    
  var uppercased: Character {
    return uppercased().first!
  }
    
  var lowercased: Character {
    return lowercased().first!
  }
    
  var isUppercase: Bool {
    return self.uppercased == self
  }
    
  var alphabetIndex: Int? {
    guard self.isASCII, self.isLetter else { return nil }
    return self.lowercased.asciiValue.flatMap(Int.init).flatMap { $0 - 96 }
  }
}
