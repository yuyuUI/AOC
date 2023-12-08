//
//  Day1.swift
//  AOC2023
//
//  Created by Dave DeLong on 12/8/23.
//  Copyright © 2023 Dave DeLong. All rights reserved.
//
import Parsing
class Day1: Day {
  static var rawInput: String? {
    return nil
    """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """
  }

  func part1() async throws -> String {
    input()
      .lines
      .map { line in
        line.characters.filter(\.isNumber)
          .map { Int(String($0))! }
      }
      .map { ints in
        guard let f = ints.first, let l = ints.last else {
          return 0
        }
        return f * 10 + l
      }
      .sum
      .description
  }

  func part2() async throws -> String {
    let lines = input().lines
    var sum = 0
    let trie = buildTrie()
    for line in lines {
      let line = line.raw
      var p1 = line.startIndex
      var p2 = line.startIndex
      while p2 < line.endIndex {
        let c = String(line[p2])
        if trie.children[c] != nil {
          p2 = line.index(after: p2)
          continue
        }
        if let number = trie.children[String(line[p1])]?.number {
          sum += Int(number)!
          p1 = line.index(after: p2)
          p2 = p1
          continue
        }
        p1 = line.index(after: p1)
        p2 = p1
      }
    }
    return sum.description
  }

  func run() async throws -> (String, String) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }

  class Node {
    init(char: String) {
      self.char = char
      self.children = [:]
      self.number = nil
    }

    var char: String
    var children: [String: Node] = [:]
    var number: String?
  }

  func buildTrie() -> Node {
    let words = [
      ["one", "1"],
      ["two", "2"],
      ["three", "3"],
      ["four", "4"],
      ["five", "5"],
      ["six", "6"],
      ["seven", "7"],
      ["eight", "8"],
      ["nine", "9"]
    ]
    let trie = Node(char: "")
    for _word in words {
      let word = _word[0]
      let number = _word[1]
      var node = trie

      for c in word {
        let c = String(c)
        if node.children[c] == nil {
          node.children[c] = Node(char: c)
        }
        node = node.children[c]!
      }
      node.number = number
    }
    return trie
  }
}

/*
 class Node:
     def __init__(self, char) -> None:
         self.char = char
         self.children = {}
         self.number = None

     def __str__(self) -> str:
         return f"Node(char={self.char},children={self.children.keys()},number={self.number})"

 def build_trie():
     words = [
         ['one','1'],
         ['two','2'],
         ['three','3'],
         ['four','4'],
         ['five','5'],
         ['six','6'],
         ['seven','7'],
         ['eight','8'],
         ['nine','9'],
     ]
     trie = Node("")

     for (word,number) in words:
         node = trie
         for c in word:
             if c not in node.children:
                 node.children[c] = Node(c)
             node = node.children[c]
         node.number = number

     return trie

 input = open("d01-input.txt")
 sum = 0
 trie = build_trie()

 for line in input:
     word = trie
     numbers = []
     p1 = p2 = 0

     while p2 < len(line):
         if line[p2].isdigit():
             numbers.append(line[p2])
             p2 += 1
             p1 = p2
             word = trie

         else:
             if line[p2] in word.children:
                 word = word.children[line[p2]]

                 if word.number:
                     numbers.append(word.number)
                     p1 = p2
                     word = trie.children.get(line[p2], trie)

                 p2 += 1

             else:
                 word = trie
                 p1 += 1
                 p2 = p1

     sum += int(numbers[0]+numbers[-1])

 print(sum)
 */
