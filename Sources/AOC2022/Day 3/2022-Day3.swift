//
//  Day3.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day3: Day {
  let c = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".map { $0 }
  func part1() async throws -> Int {
    let s = input().lines.characters.map { chars in
      let m = chars.count / 2
      let t = Set(chars[..<m]).intersection(Set(chars[m...])).first!
      return t.alphabetIndex! + (t.isUppercase ? 26 : 0)
    }.sum

    return s
  }

  func part2() async throws -> Int {
    let groups = input().lines.raw.chunks(ofCount: 3)
    return 0
//      groups.map { lines in
//        var lines = lines.map { Set($0.characters) }
//        let x = Set(lines.dropFirst())
//        return lines.reduce(x) { partialResult, s in
//          partialResult.intersection(s)
//        }.first!
//      }
//      .map { t in
//        t.alphabetIndex! + (t.isUppercase ? 26 : 0)
//      }
//      .sum
  }

  func run() async throws -> (Int, Int) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }
}
