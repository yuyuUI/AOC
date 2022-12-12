//
//  Day8.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

struct P: Hashable, CustomStringConvertible {
  var x, y: Int
  var description: String {"(\(x),\(y))"}
}

class Day8: Day {
  static var rawInput: String? {
    return nil
    """
    30373
    25512
    65332
    33549
    35390
    """
    /*
     OOOOO
     OOOXO
     OOXOO
     OXOXO
     OOOOO
     */
  }

  enum Check: String {
    case canSeem = "O"
    case canNot = "X"
  }


  lazy var rows: [[Int]] =
    input().lines.characters.map { row in
      row.compactMap { char in
        Int("\(char)")
      }
    }

  var w: Int { rows[0].count - 1 }
  var h: Int { rows.count - 1 }

  func part1() async throws -> Int {
    let left = rows.enumerated().map { y, row in can(row) }
      .enumerated().flatMap { y, point in
        point.map { P(x: $0, y: y) }
      }
    let right = rows.enumerated().map { y, row in can(row.reversed()) }
      .enumerated().flatMap { y, point in
        point.map { P(x: w - $0, y: y) }
      }

    let up = rows[0].enumerated().map { x, row in
      let temp = rows.indices.map { y in
        rows[y][x]
      }
      return can(temp)
    }.enumerated().flatMap { x, point in
      point.map { P(x: x, y: $0) }
    }

    let down = rows[0].enumerated().map { x, row in
      let temp = rows.indices.map { y in
        rows[y][x]
      }
      return can(temp.reversed())
    }.enumerated().flatMap { x, point in
      point.map { P(x: x, y: h - $0) }
    }
    let all = [left, right, up, down].flatMap { $0 }
    return Set(all).count
  }

  func part2() async throws -> Int {

    var r = Int.min
    for y in 0 ... h {
      for x in 0 ... w {
        let nh = rows[y][x]
        let uldr = get4(x, y)
        let p = [
          distance(h: nh, row: uldr.u),
          distance(h: nh, row: uldr.l),
          distance(h: nh, row: uldr.d),
          distance(h: nh, row: uldr.r),
        ]
        r = max(r, p.product)
      }
    }

    return r
  }

  struct ULDR: Equatable {
    var u, l, d, r: [Int]
  }

  func get4(_ x: Int, _ y: Int) -> ULDR {
    let rows = self.rows

    let left = Array(rows[y][..<x].reversed())
    let right = Array(rows[y][(x + 1)...])
    let up = rows[..<y].enumerated().map {
      y, row in
      row[x]
    }.reversed()
    let down = rows[(y + 1)...].enumerated().map {
      _y, row in
      row[x]
    }
    return .init(u: Array(up), l: left, d: down, r: right)
  }

  func distance(h: Int, row: [Int]) -> Int {
    for i in row.indices {
      if h <= row[i] {
        return i + 1
      }
    }
    return row.count
  }

  func can(_ array: [Int]) -> [Int] {
    var array = array
    var r = array.removeFirst()
    var result = [0]

    for (i, e) in array.enumerated() {
      if r < e {
        result.append(i + 1)
      }
      r = max(r, e)
    }
    return result
  }

  func run() async throws -> (Int, Int) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }
}
