//
//  Day1.swift
//  AOC2023
//
//  Created by Dave DeLong on 12/8/23.
//  Copyright © 2023 Dave DeLong. All rights reserved.
//

class Day1: Day {
  static var rawInput: String? {
    return nil
    """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """
  }


  func part1() async throws -> String {
    input()
      .lines
      .map { line in
        line.characters.filter(\.isNumber)
          .map { Int(String($0))! }
      }
      .map{ ints  in
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
      .map{
        line in
        mapping(line.raw)
      }
      .map{ str in
        print(str)
        return str.filter(\.isNumber).map(String.init).compactMap(Int.init)
      }
      .map{ ints  in
        print(ints)
        guard let f = ints.first, let l = ints.last else {
          return 0
        }
       return f * 10 + l
      }
      .sum
      .description
  }

  func run() async throws -> (String, String) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }
  func mapping(_ string: String) -> String {
    let list = ["😀", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    var string = string
    var i = string.startIndex
    while i != string.endIndex {
      for (int, w) in list.enumerated() {
        if string[i...].hasPrefix(w) {
          string = string.replacingOccurrences(of: w, with: int.description)
        }
      }
      i = string.index(after: i)
    }
    return string
  }
}
