//
//  Day3.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day3: Day {
//  static var rawInput: String? {
//    """
//    vJrwpWtwJgWrhcsFMMfFFhFp
//    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
//    PmmdzqPrVvPwwTWBwg
//    """
//  }

  func part1() async throws -> Int {
    let s = input().lines.characters.map { chars in
      let m = chars.count / 2
      let t = Set(chars[..<m]).intersection(Set(chars[m...])).first!
      return t.alphabetIndex! + (t.isUppercase ? 26 : 0)
    }.sum

    return s
  }

  func part2() async throws -> Int {
    input().lines.characters.chunks(ofCount: 3).map { lines in
      lines.intersection.first!
    }.map { c in
      c.alphabetIndex! + (c.isUppercase ? 26 : 0)
    }.sum
  }

  func run() async throws -> (Int, Int) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }
}
