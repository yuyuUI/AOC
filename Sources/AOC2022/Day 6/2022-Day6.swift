//
//  Day6.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day6: Day {
  fileprivate func markIndex(_ distinctCharacters: Int) -> Int {
    return input().lines.characters.map { chars in
      var ptn = distinctCharacters
      return (
        chars.windows(ofCount: distinctCharacters)
          .lazy.enumerated().first { i, chars in
            Set(chars).count == distinctCharacters
          }?.0 ?? 0
      ) + distinctCharacters
      for (i, w) in chars.windows(ofCount: distinctCharacters).enumerated() {
        if Set(w).count == distinctCharacters {
          print(w, i, i + distinctCharacters)
          break
        }
      }
      while ptn < chars.count {
        if Set(chars[(ptn - distinctCharacters) ..< ptn]).count == distinctCharacters {
          return ptn
        }
        ptn += 1
      }
      return 0
    }.sum
  }

  func part1() async throws -> Int {
    markIndex(4)
  }

  func part2() async throws -> Int {
    markIndex(14)
  }

  func run() async throws -> (Int, Int) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }
}

