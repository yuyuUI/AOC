//
//  Day12.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day12: Day {
  static var rawInput: String? {
    return nil
    """
    Sabqponm
    abcryxxl
    accszExk
    acctuvwj
    abdefghi
    """
    /*
     v..v<<<<
     >v.vv<<^
     .>vv>E^^
     ..v>>>^^
     ..>>>>>^
     SabcccdefghijklmnopqrnsuvwxxxyzE
     */
  }

  func get() -> ([[Int]], s: P, e: P) {
    let board = input().lines.characters
    var s = P(x: .min, y: .min)
    var e = P(x: .min, y: .min)
    for y in board.indices {
      for x in board[y].indices {
        if board[y][x] == "S" { s = P(x: x, y: y) }
        if board[y][x] == "E" { e = P(x: x, y: y) }
      }
    }

    var b = board.map { line in
      line.map(
        {
          $0.alphabetIndex!
        }
      )
    }
    b[s.y][s.x] = 1
    b[e.y][e.x] = 26
    return (b, s, e)
  }

  func part1() async throws -> Int {
    let (board, s, e) = get()
    print(s, e)

    var paths: Set<[P]> = []

    func backtrack(path: [P], visited: Set<P>) {
      print(visited.sorted(by: {$0.x < $1.x}))
//      print(path.last!, path.map { alphabet[board[$0.y][$0.x]] }.joined())

      var localVisited = visited
      if path.last! == e {
        paths.insert(path)
        return
      }
      let p = path.last!

      let adjacents = [
        (0, -1),
        (0, +1),
        (-1, 0),
        (+1, 0),
      ]
      for (dx, dy) in adjacents {
        let a = P(x: p.x + dx, y: p.y + dy)
        if visited.contains(a) { continue }
        localVisited.insert(a)
        if board.indices.contains(a.y),
           board[a.y].indices.contains(a.x) {
          if [0, 1].contains(board[a.y][a.x] - board[p.y][p.x]) {
            var temp = visited
            temp.insert(a)
            backtrack(path: path + [a], visited: temp)
          }
        }
      }
    }
    backtrack(path: [s], visited: [s])

    for p in paths {
      print(p.map { alphabet[board[$0.y][$0.x]] }.joined())
    }

    let shortest = paths.sorted(by: { $0.count < $1.count })[0]
//    print(shortest.map{($0.x, $0.y)})
//    print(shortest.map { alphabet[board[$0.y][$0.x]] }.joined())
    print(shortest.count)
    return shortest.count - 1
    return 31
  }

  let alphabet = "0abcdefghijklmnopqrstuvwxyz".map { $0.description }
  func part2() async throws -> String {
    return #function
  }

  func run() async throws -> (Int, String) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }
}
