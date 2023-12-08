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
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
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
        ints.first! * 10 + ints.last!
      }
      .sum
      .description
  }

  func part2() async throws -> String {
    return #function
  }

  func run() async throws -> (String, String) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }
}
