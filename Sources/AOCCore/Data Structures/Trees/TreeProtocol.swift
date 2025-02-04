//
//  File.swift
//  
//
//  Created by Dave DeLong on 12/6/22.
//

import Foundation

public protocol TreeNode {
    var children: Array<Self> { get }
    var isLeaf: Bool { get }
}

public protocol TreeTraversingDisposition {
    static var keepGoing: Self { get }
    var aborts: Bool { get }
}

public protocol TreeTraversing {
    associatedtype Disposition: TreeTraversingDisposition
    associatedtype Node: TreeNode
    
    func traverse(node: Node, level: Int, visitor: (Node, Int) throws -> Disposition) rethrows -> Disposition
}

extension TreeTraversing {
    
    internal func traverse(node: Node, visitor: (Node) throws -> Disposition) rethrows -> Disposition {
        return try self.traverse(node: node, level: 0, visitor: { node, _ in
            return try visitor(node)
        })
    }
    
    internal func traverse(node: Node, visitor: (Node, Int) throws -> Disposition) rethrows -> Disposition {
        return try self.traverse(node: node, level: 0, visitor: visitor)
    }
    
}

public extension TreeNode {
    
    var isLeaf: Bool { return children.isEmpty }
    
    @discardableResult
    func traverse<T: TreeTraversing>(in order: T, visitor: (Self) throws -> T.Disposition) rethrows -> T.Disposition where T.Node == Self {
        return try order.traverse(node: self, visitor: visitor)
    }
    
    @discardableResult
    func traverse<T: TreeTraversing>(in order: T, visitor: (Self, Int) throws -> T.Disposition) rethrows -> T.Disposition where T.Node == Self {
        return try order.traverse(node: self, visitor: visitor)
    }
    
    @discardableResult
    func traverse(visitor: (Self) throws -> PreOrderTraversal<Self>.Disposition) rethrows -> PreOrderTraversal<Self>.Disposition {
        return try traverse(in: PreOrderTraversal(), visitor: visitor)
    }
    
    @discardableResult
    func traverse(visitor: (Self, Int) throws -> PreOrderTraversal<Self>.Disposition) rethrows -> PreOrderTraversal<Self>.Disposition {
        return try traverse(in: PreOrderTraversal(), visitor: visitor)
    }
    
    func flatten<T: TreeTraversing>(in order: T) -> Array<T.Node> where T.Node == Self {
        var flattened = Array<T.Node>()
        
        traverse(in: order) {
            flattened.append($0)
            return T.Disposition.keepGoing
        }
        
        return flattened
    }
    
    var flattened: Array<Self> {
        return flatten(in: PreOrderTraversal())
    }
    
    var preOrder: Array<Self> { flatten(in: PreOrderTraversal()) }
    
    var postOrder: Array<Self> { flatten(in: PostOrderTraversal()) }
    
    var breadthFirstOrder: Array<Self> { flatten(in: BreadthFirstTreeTraversal()) }
    
    func treeDescription(using describer: (Self) -> String) -> String {
        var lines = Array<String>()
        self.traverse(in: PreOrderTraversal(), visitor: { node, level in
            let symbol = node.isLeaf ? "-" : "+"
            lines.append(String(repeating: "  ", count: level) + symbol + " " + describer(node))
            return .continue
        })
        return lines.joined(separator: "\n")
    }
    
}

extension TreeNode where Self: CustomStringConvertible {
    
    public var treeDescription: String { self.treeDescription(using: \.description) }
    
}

public extension Collection where Element: TreeNode {
    
    func traverseElements<T: TreeTraversing>(in order: T, visitor: (Element) throws -> T.Disposition) rethrows where T.Node == Element {
        for item in self {
            let d = try item.traverse(in: order, visitor: visitor)
            if d.aborts { return }
        }
    }
    
    func traverseElements(visitor: (Element) throws -> PreOrderTraversal<Element>.Disposition) rethrows {
        try traverseElements(in: PreOrderTraversal(), visitor: visitor)
    }
    
    func flatten<T: TreeTraversing>(in order: T) -> Array<T.Node> where T.Node == Element {
        var flattened = Array<T.Node>()
        for node in self {
            node.traverse(in: order) {
                flattened.append($0)
                return T.Disposition.keepGoing
            }
        }
        return flattened
    }
    
    func flatten() -> Array<Element> {
        return flatten(in: PreOrderTraversal())
    }
    
}
