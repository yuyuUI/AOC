//
//  Day1.swift
//  AOC2023
//
//  Created by Dave DeLong on 12/8/23.
//  Copyright © 2023 Dave DeLong. All rights reserved.
//
import Parsing
class Day1: Day {
  static var rawInput: String? {
    return nil
    """
    eightwothree
    """
  }

  func part1() async throws -> String {
    input()
      .lines
      .map { line in
        line.characters.filter(\.isNumber)
          .map { Int(String($0))! }
      }
      .map { ints in
        guard let f = ints.first, let l = ints.last else {
          return 0
        }
        return f * 10 + l
      }
      .sum
      .description
  }

  func part2() async throws -> String {
    input()
      .lines
      .map(\.raw)
      .map(mapping)
      .map {
        line in
        line.filter(\.isNumber)
      }
      .map { line in
        Int(String(line.first!) + String(line.last!))!
      }

      .sum
      .description
  }

  func mapping(_ string: String) -> String {
    let list = ["😀", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    let words = [
      "one": "o1e",
      "two": "t2o",
      "three": "th3ee",
      "four": "f4r",
      "five": "f5e",
      "six": "s6x",
      "seven": "s7n",
      "eight": "e8t",
      "nine": "n9e"
    ]
    var string = string
    var i = string.startIndex
    while i != string.endIndex {
      for (int, w) in list.enumerated() {
        if string[i...].hasPrefix(w) {
          string = string.replacingOccurrences(of: w, with: words[w]!)
        }
      }
      i = string.index(after: i)
    }
    return string
  }

  func run() async throws -> (String, String) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }
}
