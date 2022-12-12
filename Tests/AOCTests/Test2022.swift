//
//  Test2022.swift
//  AOCTests
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

@testable import AOC2022
import Parsing
import XCTest

@MainActor
class Test2022: XCTestCase {
  func testDay1() async throws {
    let d = Day1()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, 71471)
    XCTAssertEqual(p2, 211_189)
  }

  func testDay2() async throws {
    let d = Day2()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, 13809)
    XCTAssertEqual(p2, 12316)
  }

  func testDay3() async throws {
    let d = Day3()
    let (p1, p2) = try await d.run()
    XCTAssertEqual(p1, 7674)
    XCTAssertEqual(p2, 2805)
    XCTAssertEqual([[1], [2], [3]].intersection, [])
    XCTAssertEqual([[1], [1, 2], [1, 3]].intersection, [1])
  }

  func testDay4() async throws {
    let d = Day4()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, 431)
    XCTAssertEqual(p2, 823)
    XCTAssertEqual(intersect(2 ... 4, 6 ... 8), false)
    XCTAssertEqual(intersect(2 ... 3, 4 ... 5), false)
    XCTAssertEqual(intersect(5 ... 7, 7 ... 9), false)
    XCTAssertEqual(intersect(2 ... 8, 3 ... 7), true)
    XCTAssertEqual(intersect(6 ... 6, 4 ... 6), true)
    XCTAssertEqual(intersect(2 ... 6, 4 ... 8), false)
    XCTAssertEqual(intersect(1 ... 2, 3 ... 7), false)
    XCTAssertEqual(intersect(1 ... 2, 2 ... 3), false)
    XCTAssertEqual(intersect(1 ... 1, 1 ... 1), true)
    XCTAssertEqual(intersect(1 ... 2, 2 ... 2), true)
  }

  func testDay5() async throws {
    let d = Day5()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "JDTMRWCQJ")
    XCTAssertEqual(p2, "VHJDDCWRD")
  }

  func testDay6() async throws {
    let d = Day6()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, 1987)
    XCTAssertEqual(p2, 3059)
  }

  func testDay7() async throws {
    let d = Day7()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, 1_989_474)
    XCTAssertEqual(p2, 1_111_607)
    //    XCTAssertEqual(p1, 95437)
    //    XCTAssertEqual(p2, 24933642)
  }

  func testDay8() async throws {
    let d = Day8()
    let (p1, p2) = try await d.run()

    //    XCTAssertEqual(p1, 21)
    XCTAssertEqual(p1, 1693)
    XCTAssertEqual(p2, 422_059)
    //    XCTAssertEqual(p2, 8)
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

  func testDay9() async throws {
    let d = Day9()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, 6197)
//    XCTAssertEqual(p1, 13)
//    XCTAssertEqual(p2, 1)
    XCTAssertEqual(p2, 2562)
    XCTAssertEqual(d.move(h: .init(x: 0, y: 0), t: .init(x: 0, y: 0)), .init(x: 0, y: 0))
    XCTAssertEqual(d.move(h: .init(x: 1, y: 0), t: .init(x: 0, y: 0)), .init(x: 0, y: 0))
    XCTAssertEqual(d.move(h: .init(x: 2, y: 0), t: .init(x: 0, y: 0)), .init(x: 1, y: 0))
    XCTAssertEqual(d.move(h: .init(x: 3, y: 0), t: .init(x: 1, y: 0)), .init(x: 2, y: 0))
    XCTAssertEqual(d.move(h: .init(x: 4, y: 0), t: .init(x: 2, y: 0)), .init(x: 3, y: 0))
    XCTAssertEqual(d.move(h: .init(x: 4, y: 1), t: .init(x: 3, y: 0)), .init(x: 3, y: 0))
    XCTAssertEqual(d.move(h: .init(x: 4, y: 2), t: .init(x: 3, y: 0)), .init(x: 4, y: 1))
    XCTAssertEqual(d.move(h: .init(x: 3, y: 4), t: .init(x: 4, y: 3)), .init(x: 4, y: 3))
    XCTAssertEqual(d.move(h: .init(x: 2, y: 4), t: .init(x: 4, y: 3)), .init(x: 3, y: 4))

    var points = [P(x: 0, y: 0), P(x: 0, y: 0)]
    XCTAssertEqual(headMove(to: P(x: 0, y: 0), points), [P(x: 0, y: 0), P(x: 0, y: 0)])
    XCTAssertEqual(headMove(to: P(x: 1, y: 0), points), [P(x: 1, y: 0), P(x: 0, y: 0)])
    points = [P(x: 1, y: 0), P(x: 0, y: 0)]
    XCTAssertEqual(headMove(to: P(x: 2, y: 0), points), [P(x: 2, y: 0), P(x: 1, y: 0)])
  }

  func testDay10() async throws {
    let d = Day10()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay11() async throws {
    let d = Day11()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, 10605)
//    XCTAssertEqual(p2, 0)
  }

  func test() throws {
    let monkeyRaw =
      """
      Monkey 0:
        Starting items: 79, 98
        Operation: new = old * 19
        Test: divisible by 23
          If true: throw to monkey 2
          If false: throw to monkey 3
      """

   let parse = Parse {
      Parse {
        "Monkey "
        Int.parser()
        ":\n"
      }
      Parse {
        "  Starting items: "
        Many {
          Int.parser()
        } separator: {
          ", "
        } terminator: {
          "\n"
        }
      }
      Parse {
        "  Operation: new = old "
        OneOf {
          Parse {
            "+ "
            Int.parser()
          }.map{"+ \($0)"}
          Parse {
            "* "
            Int.parser()
          }.map{"* \($0)"}
          Parse {
            "* old"
          }.map{"square"}
        }
      }
      Parse {
        "\n  Test: divisible by "
        Int.parser()
      }
      Parse {
        "\n    If true: throw to monkey "
        Int.parser()
      }
      Parse {
        "\n    If false: throw to monkey "
        Int.parser()
      }
    }
    do {
      let monkey = try parse.parse(monkeyRaw)
      dump(monkey)
      let monkeys = try Many {
        parse
      } separator: {
        "\n\n"
      }.parse(Day11.rawInput!)
      dump(monkeys)
    }
    catch {
      print(error)
    }
  }

  func testDay12() async throws {
    let d = Day12()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay13() async throws {
    let d = Day13()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay14() async throws {
    let d = Day14()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay15() async throws {
    let d = Day15()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay16() async throws {
    let d = Day16()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay17() async throws {
    let d = Day17()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay18() async throws {
    let d = Day18()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay19() async throws {
    let d = Day19()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay20() async throws {
    let d = Day20()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay21() async throws {
    let d = Day21()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay22() async throws {
    let d = Day22()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay23() async throws {
    let d = Day23()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay24() async throws {
    let d = Day24()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay25() async throws {
    let d = Day25()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  // MARK: - PoC

  func testIntersection() throws {
    let lines = [
      "NsgwPPDgsPHqsTqqmLbLrDRhmrRVrbVW",
      "lFpGFtfFlvSFplGFzptSGSSlhZbhjhfrmWbhLhmLbCZVZjWr",
      "ccplJQSGcSSpVFvNqqsqPNqPQPTwqd",
    ].map { $0.map { $0 }}
    XCTAssertEqual(
      lines.intersectingElements(),
      ["V", "q", "N", "P", "s", "T", "w"]
    )
    XCTAssertEqual(
      lines.intersection,
      ["V"]
    )
  }
}

import Algorithms
extension WindowsOfCountCollection where Base.Index == Int {
  func baseIndex(of index: Index) -> Base.Index {
    let x = self[index]
    dump(x)
    return 0
  }
}
