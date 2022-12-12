//
//  Day11.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//
import CasePaths
import Parsing
class Day11: Day {
  static var rawInput: String? {
    """
    Monkey 0:
      Starting items: 79, 98
      Operation: new = old * 19
      Test: divisible by 23
        If true: throw to monkey 2
        If false: throw to monkey 3

    Monkey 1:
      Starting items: 54, 65, 75, 74
      Operation: new = old + 6
      Test: divisible by 19
        If true: throw to monkey 2
        If false: throw to monkey 0

    Monkey 2:
      Starting items: 79, 60, 97
      Operation: new = old * old
      Test: divisible by 13
        If true: throw to monkey 1
        If false: throw to monkey 3

    Monkey 3:
      Starting items: 74
      Operation: new = old + 3
      Test: divisible by 17
        If true: throw to monkey 0
        If false: throw to monkey 1
    """
  }

  enum Line {
    case monkey(Int)
    case startingItem([Double])
    case operation(Command)
    case testDivisible(Int)
    case ifTrue(toMonkey: Int)
    case ifFalse(toMonkey: Int)
  }

  enum Command {
    case add(Int)
    case time(Int)
    case square
    func apply(target: Int) -> Int {
      switch self {
      case let .add(value): return target + value
      case let .time(value): return target * value
      case .square: return target * target
      }
    }
  }

  let parser = {
    let monkey = Parse(MonkeyObj.init) {
      Parse {
        "Monkey "
        Int.parser()
        ":"
      }
      Parse {
        Whitespace(1, .vertical)
        Whitespace(2, .horizontal)
        "Starting items: "
        Many {
          Int.parser()
        } separator: {
          ", "
        } terminator: {
          "\n"
        }
      }
      Parse {
        Whitespace(2, .horizontal)
        "Operation: new = old "
        OneOf {
          Parse(Command.add) {
            "+ "
            Int.parser()
          }
          Parse(Command.time) {
            "* "
            Int.parser()
          }
          Parse(Command.square) {
            "* old"
          }
        }
      }
      Parse {
        Whitespace(1, .vertical)
        Whitespace(2, .horizontal)
        "Test: divisible by "
        Int.parser()
      }
      Parse {
        Whitespace(1, .vertical)
        Whitespace(4, .horizontal)
        "If true: throw to monkey "
        Int.parser()
      }
      Parse {
        Whitespace(1, .vertical)
        Whitespace(4, .horizontal)
        "If false: throw to monkey "
        Int.parser()
      }
    }

    return Many {
      monkey
    } separator: {
      Whitespace(2, .vertical)
    }
  }()

  class MonkeyObj {
    internal init(
      id: Int,
      startingItem: [Int],
      operation: Day11.Command,
      testDivisible: Int,
      ifTrueToMonkey: Int,
      ifFalseToMonkey: Int
    ) {
      self.id = id
      self.startingItem = startingItem
      self.operation = operation
      self.testDivisible = testDivisible
      self.ifTrueToMonkey = ifTrueToMonkey
      self.ifFalseToMonkey = ifFalseToMonkey
    }

    var id: Int
    var startingItem: [Int]
    var operation: Command
    var testDivisible: Int
    var ifTrueToMonkey: Int
    var ifFalseToMonkey: Int
    var inspectCount = 0

    func play() {
      for i in startingItem.indices {
        inspectCount += 1
        startingItem[i] = operation.apply(target: startingItem[i])
        startingItem[i] = startingItem[i] / 3
      }
    }

    func thrown() -> [(id: Int, value: Int)] {
      let pairs = startingItem.map { item in

        (
          item.isMultiple(of: testDivisible) ? ifTrueToMonkey : ifFalseToMonkey,
          item
        )
      }
      startingItem.removeAll()
      return pairs
    }
  }

  fileprivate func genMonkeys() throws -> [MonkeyObj] {
    try parser.parse(input().raw)
  }

  fileprivate func mostActiveMonkeyProduct(totalRound total: Int) throws -> Int {
    let monkeys = try genMonkeys().sorted { $0.id < $1.id }
    var round = 0
    while round < total {
      round += 1
      for monkey in monkeys {
        monkey.play()
        let pairs = monkey.thrown()
        for (id, value) in pairs {
          monkeys[id].startingItem.append(value)
        }
      }
      print(monkeys.map(\.startingItem))
    }
    return monkeys.map(\.inspectCount).max(count: 2).product
  }

  func run() async throws -> (Int, Int) {
    let p1 = 10605 // try mostActiveMonkeyProduct(totalRound: 20)
    let p2 = 0 // try mostActiveMonkeyProduct(totalRound: 10000)
    return (p1, p2)
  }
}
