//
//  Day5.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

import Parsing

class Day5: Day {
  struct Command {
    let count, from, to: Int
  }

  let commandParse = Parse(Command.init) {
    "move "
    Int.parser()
    " from "
    Int.parser()
    " to "
    Int.parser()
  }

  func parse() throws -> ([[String]], [Command]) {
    let parts = input().lines.split(on: \.isEmpty)
    var part1 = parts[0]
    part1.removeLast()
    var rows: [[String]] = []

    for raw in part1.raw.map({ $0.chunks(ofCount: 4) }) {
      var temp: [String] = []
      for word in raw {
        temp.append(word.description.trimmingCharacters(in: .init(charactersIn: "[] ")))
      }
      rows.append(temp)
    }

    var stacks: [[String]] = [[]]
    for i in 0 ..< (rows.map(\.count).max()!) {
      var temp: [String] = []
      for j in rows.indices.reversed() {
        if rows[j].indices.contains(i), rows[j][i].isEmpty == false {
          temp.append(rows[j][i])
        }
      }
      stacks.append(temp)
    }

    let commands = try parts[1].raw.map { try commandParse.parse($0)
    }
    return (stacks, commands)
  }

  func part1() async throws -> String {
    var (stacks, commands) = try parse()
    for command in commands {
      var temp: [String] = []
      for _ in 0 ..< command.count {
        temp.append(stacks[command.from].popLast()!)
      }
      stacks[command.to].append(contentsOf: temp)
    }
    return stacks.compactMap(\.last).joined()
  }

  func part2() async throws -> String {
    var (stacks, commands) = try parse()
    for command in commands {
      var temp: [String] = []

      for _ in 0 ..< command.count {
        temp.append(stacks[command.from].popLast()!)
      }

      temp.reverse()

      stacks[command.to].append(contentsOf: temp)
    }
    return stacks.compactMap(\.last).joined()
  }

  func run() async throws -> (String, String) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }
}
