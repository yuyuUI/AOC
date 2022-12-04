//
//  Day4.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day4: Day {
  func part1() async throws -> Int {
    let ranges = input().lines.words(separatedBy: ",").map {
      words in
      words.raw.map { $0.split(on: "-") }
    }
    .map { range in
      let range1 = range[0].map { Int("\($0)")! }
      let range2 = range[1].map { Int("\($0)")! }
      return (range1[0]...range1[1],
              range2[0]...range2[1])
    }
    for range in ranges {
      print(range.0, range.1, intersect(range.0, range.1))
    }

    return ranges.filter(intersect).count
  }

  func part2() async throws -> Int {
    let ranges = input().lines.words(separatedBy: ",").map {
      words in
      words.raw.map { $0.split(on: "-") }
    }
    .map { range in
      let range1 = range[0].map { Int("\($0)")! }
      let range2 = range[1].map { Int("\($0)")! }
      return (range1[0]...range1[1],
              range2[0]...range2[1])
    }
    return ranges.filter { $0.0.overlaps($0.1) }.count
  }

  func run() async throws -> (Int, Int) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }
}

func intersect(_ x: ClosedRange<Int>, _ y: ClosedRange<Int>) -> Bool {
  return (x.upperBound <= y.upperBound &&
    x.lowerBound >= y.lowerBound) || (x.upperBound >= y.upperBound && x.lowerBound <= y.lowerBound)
}
