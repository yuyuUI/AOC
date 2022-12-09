//
//  Day9.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//
import Parsing

class Day9: Day {
  static var rawInput: String? {
    return nil
    """
    R 4
    U 4
    L 3
    D 1
    R 4
    D 1
    L 5
    R 2
    """
  }

  enum UDLR {
    case u(Int), d(Int), l(Int), r(Int)
  }

  lazy var steps = {
    let parser = Many {
      OneOf {
        Parse(UDLR.r) {
          "R "
          Int.parser()
        }
        Parse(UDLR.u) {
          "U "
          Int.parser()
        }
        Parse(UDLR.l) {
          "L "
          Int.parser()
        }
        Parse(UDLR.d) {
          "D "
          Int.parser()
        }
      }
    } separator: {
      "\n"
    }
    return try! parser.parse(self.input().raw)
  }()

  fileprivate func getPath(_ points: [P]) -> Int {
    var points = points
    var h = points.first!
    var set: Set<P> = []
    for step in steps {
      switch step {
      case let .u(c):
        for _ in 1 ... c {
          h.y += 1
          points = headMove(to: h, points)
          set.insert(points.last!)
        }
      case let .d(c):
        for _ in 1 ... c {
          h.y -= 1
          points = headMove(to: h, points)
          set.insert(points.last!)
        }

      case let .l(c):
        for _ in 1 ... c {
          h.x -= 1
          points = headMove(to: h, points)
          set.insert(points.last!)
        }

      case let .r(c):
        for _ in 1 ... c {
          h.x += 1
          points = headMove(to: h, points)
          set.insert(points.last!)
        }
      }
    }
    return set.count
  }

  func part1() async throws -> Int {
    let points = Array(repeating: P(x: 0, y: 0), count: 2)
    return getPath(points)
  }

  func part2() async throws -> Int {
    let points = Array(repeating: P(x: 0, y: 0), count: 10)
    return getPath(points)
    return 1
  }

  func run() async throws -> (Int, Int) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }

  func headMove(to h: P, _ points: [P]) -> [P] {
    let d = Day9()
    var points = points
    points[0] = h
    for i in points.indices {
      if i == 0 { continue }
      let new = d.move(h: points[i - 1], t: points[i])
      points[i] = new
    }
    return points
  }

  func move(h: P, t: P) -> P {
    var (x, y) = (0, 0)
    if abs(h.x - t.x) < 2, abs(h.y - t.y) <
      2 {
      return t
    }
    if h.x - t.x > 1 {
      x = -1
    } else if h.x - t.x < -1 {
      x = +1
    }
    if h.y - t.y > 1 {
      y = -1
    } else if h.y - t.y < -1 {
      y = +1
    }
    return .init(x: h.x + x, y: h.y + y)
  }
}
