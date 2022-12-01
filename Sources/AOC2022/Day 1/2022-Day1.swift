//
//  Day1.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day1: Day {

  func run() async throws -> (Int, Int) {
    let x = input().raw.components(separatedBy: "\n")
    var elves:[Int] = []
    
    var temp = 0
    for line in x {
      if line.isEmpty {
        elves.append(temp)
        temp = 0
        continue
      }
      temp += Int(line) ?? 0
    }
    elves.sort(by:>)
    return (elves[0], elves[0...2].reduce(0,+))
  }
    func run2() async throws -> (Int, Int) {
        let elves = input().lines.split(on: \.isEmpty).map(\.integers.sum)
        let p1 = elves.max()!
        let p2 = elves.max(count: 3).sum
        return (p1, p2)
    }

}
