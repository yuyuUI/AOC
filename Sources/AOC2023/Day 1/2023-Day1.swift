//
//  Day1.swift
//  AOC2023
//
//  Created by Dave DeLong on 12/8/23.
//  Copyright © 2023 Dave DeLong. All rights reserved.
//

class Day1: Day {
  static var rawInput: String? {
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
    return #function
  }

  func run() async throws -> (String, String) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }
}
