//
//  Day2.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day2: Day {
  enum ABC: String {
    case rock = "A" // rock 1
    case paper = "B" // paper 2
    case scissor = "C" // Scissors 3
  }


  func part1() async throws -> Int {
    enum XYZ: String {
      case rock = "X" // rock 1
      case paper = "Y" // paper 2
      case scissor = "Z" // Scissors 3
    }
    let rounds = input().lines.words
      .map { word in
        (ABC(rawValue: word[0].raw)!,
         XYZ(rawValue: word[1].raw)!)
      }
    return rounds.reduce(into: 0) { p, pair in
      let (abc, xyz) = pair
      switch (xyz, abc) {
        case (.rock, .rock): p += (3+1)
        case (.rock, .paper): p += (0+1)
        case (.rock, .scissor): p += (6+1)
        case (.paper, .rock): p += (2+6)
        case (.paper, .paper): p += (2+3)
        case (.paper, .scissor): p += (2+0)
        case (.scissor, .rock): p += 3+0
        case (.scissor, .paper): p += 3+6
        case (.scissor, .scissor): p += 3+3
      }
    }
  }

  func part2() async throws -> Int {
    enum XYZ: String {
      case lose = "X" // rock 1
      case draw = "Y" // paper 2
      case win = "Z" // Scissors 3
    }
    let rounds = input().lines.words
      .map { word in
        (ABC(rawValue: word[0].raw)!,
         XYZ(rawValue: word[1].raw)!)
      }
    return rounds.reduce(into: 0) { p, pair in
      let (abc, xyz) = pair
      switch (xyz, abc) {
        case (.lose, .rock): p += (0+3)
        case (.lose, .paper): p += (0+1)
        case (.lose, .scissor): p += (0+2)
        case (.draw, .rock): p += (1+3)
        case (.draw, .paper): p += (2+3)
        case (.draw, .scissor): p += (3+3)
        case (.win, .rock): p += 2+6
        case (.win, .paper): p += 3+6
        case (.win, .scissor): p += 1+6
      }
    }
  }

  func run() async throws -> (Int, Int) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }
}
