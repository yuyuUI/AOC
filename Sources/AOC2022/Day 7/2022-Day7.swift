//
//  Day7.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
import Parsing
class Day7: Day {
  static var rawInput: String? {
    return nil
    """
    $ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k
    """
  }

  enum T {
    case file
    case dir
  }

  class Node {
    internal init(name: String, t: T, upper: Node?, child: [Node]) {
      self.name = name
      self.t = t
      self.upper = upper
      self.child = child
    }

    var name: String
    var size = 0
    var t: T
    var upper: Node!
    var child: [Node]
  }

  enum SingleLine {
    case dir(String)
    case fileSize(Int, String)
    case ls
    case cd(String)
  }

  let parser = {
    let dir = Parse(SingleLine.dir) {
      "dir "
      Prefix { $0 != "\n" }.map(String.init)
    }
    let fileSize = Parse(SingleLine.fileSize) {
      Int.parser()
      " "
      Prefix { $0 != "\n" }.map(String.init)
    }
    let ls = Parse(SingleLine.ls) {
      "$ ls"
    }
    let cd = Parse(SingleLine.cd) {
      "$ cd "
      Prefix { $0 != "\n" }.map(String.init)
    }

    let line = OneOf {
      dir
      fileSize
      ls
      cd
    }

    return Many {
      line
    } separator: {
      "\n"
    } /* terminator: {
       End()
     } */
  }()

  func run() async throws -> (Int, Int) {
    let lines: [Day7.SingleLine]
    do {
      lines = try parser.parse(input().raw)
    } catch {
      print(error)
      fatalError()
    }

    let dummy = Node(name: "dummy", t: .dir, upper: nil, child: [])
    var node = dummy

    for line in lines {
      switch line {
      case .cd("/"):
        let n = Node(name: "root", t: .dir, upper: node, child: [])
        node.child = [n]
        node = n
      case .cd(".."):
        node = node.upper
      case let .dir(name):
        if node.child.contains(where: { $0.name == name }) { break }
        node.child.append(Node(
          name: name,
          t: .dir,
          upper: node,
          child: []
        ))
      case let .fileSize(size, name):
        if node.child.contains(where: { $0.name == name }) { break }
        let n = Node(name: name, t: .file, upper: node, child: [])
        n.size = size
        node.child.append(n)
      case .ls:
        break
      case let .cd(name):
        let n = node.child.first { $0.name == name }!
        node = n
      }
    }
    travel(dummy.child[0])
    /*
     - / (dir) 48381165
       - a (dir) 94853
         - e (dir) 584
           - i (file, size=584)
         - f (file, size=29116)
         - g (file, size=2557)
         - h.lst (file, size=62596)
       - b.txt (file, size=14848514)
       - c.dat (file, size=8504156)
       - d (dir) 24933642
         - j (file, size=4060174)
         - d.log (file, size=8033020)
         - d.ext (file, size=5626152)
         - k (file, size=7214296)
     70000000 - 48381165 = 21618835
     */

    let all = get(dummy.child[0])
    let p1 = all.map(\.0).filter { $0 <= 100_000 }.sum
    let total = 30_000_000 - (70_000_000 - dummy.child[0].size)
    let p2 = all.map(\.0).filter { $0 >= total }.min()!

    return (p1, p2)
  }

  func travel(_ node: Node) {
    for child in node.child {
      travel(child)
    }
    switch node.t {
    case .dir:
      let sizes = node.child.map(\.size).sum
      node.size = sizes
    case .file:
      break
    }
  }

  func get(_ node: Node) -> [(Int, String)] {
    var all: [(Int, String)] = []
    func tchild(_ node: Node) {
      switch node.t {
      case .dir:
        all.append((node.size, node.name))
        for child in node.child {
          tchild(child)
        }
      case .file:
        break
      }
    }
    tchild(node)
    return all
  }
}
