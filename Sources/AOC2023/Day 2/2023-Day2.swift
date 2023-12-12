//
//  Day2.swift
//  AOC2023
//
//  Created by Dave DeLong on 12/8/23.
//  Copyright © 2023 Dave DeLong. All rights reserved.
//

import Parsing
class Day2: Day {
  static var rawInput: String? {
    return nil
    """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """
  }

  struct Game {
    var index: Int
    var rounds: [Round]
  }

  struct Round {
    var blue, red, green: Int
    init(_ list: [(Int, Color)]) {
      var (blue, red, green) = (0, 0, 0)
      for (count, color) in list {
        switch color {
        case .blue: blue = count
        case .red: red = count
        case .green: green = count
        }
      }
      self.blue = blue
      self.red = red
      self.green = green
    }
  }

  enum Color: Comparable {
    case blue, red, green
  }

  let parser = Parse {
    "Game "
    Int.parser()
    ":"
    Whitespace()

    Many {
      Many {
        Int.parser()
        Whitespace()
        OneOf {
          "blue".map { Color.blue }
          "red".map { Color.red }
          "green".map { Color.green }
        }
      } separator: {
        ","
        Whitespace()
      }
      .map {
        $0.sorted(by: { $0.1 < $1.1 })
      }
    } separator: {
      ";"
      Whitespace()
    }
  }
  .map {
    index, round in

    Game(index: index, rounds: round.map(Round.init))
  }

  func part1() async throws -> String {
    input()
      .lines
      .map { line in
        try! parser.parse(line.raw)
      }
      .filter(checkGame)
      .map(\.index)
      .sum
      .description
  }

  func part2() async throws -> String {
    input()
      .lines
      .map { line in
        try! parser.parse(line.raw)
      }
      .map(mapGame)
      .map{c in
        c.reduce(into: 1, *=)
      }
      .sum
      .description

  }

  func run() async throws -> (String, String) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }

  func checkGame(_ game: Game) -> Bool {
    let (r, g, b) = (12, 13, 14)

    for round in game.rounds {
      if round.red > r || round.green > g || round.blue > b {
        return false
      }
    }
    return true
  }

  func mapGame(_ game: Game) -> [Int] {
    var (r, g, b) = (0, 0, 0)

    for round in game.rounds {
      r = max(round.red, r)
      g = max(round.green, g)
      b = max(round.blue, b)
    }
    return [r, g, b]
  }
}
