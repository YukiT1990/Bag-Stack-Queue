//
//  Bag.swift
//  Datastructure1
//
//  Created by Yuki Tsukada on 2021/03/16.
//

import Foundation

/// The **Bag** class represents a bag of generic items.
/// It supports insertion and iterating over the items in arbitrary order.
/// This implementation uses a singly linked list with an inner class Node.
/// The *add*, *isEmpty*, and *count* operations take constant time *O(1)*. Iteration takes linear time *O(n)*.
public final class Bag<E> : Sequence {
    // begining of bag
    private var first: Node<E>? = nil
    
    // number of elements in bag
    private(set) var count: Int = 0
    
    // helper linked list node class
    fileprivate class Node<E> {
        fileprivate var item: E
        fileprivate var next: Node<E>?
        fileprivate init(item: E, next: Node<E>? = nil) {
            self.item = item
            self.next = next
        }
    }
    
    // Initializers an empty bag.
    public init() {}
    
    public func isEmpty() -> Bool {
        return first == nil
    }
    
    // Adds the item to this bag (front)
    public func add(item: E) {
        let oldFirst = first
        first = Node<E>(item: item, next: oldFirst)
        count += 1
    }
    
    public struct BagIterator<E> : IteratorProtocol {
        public typealias Element = E
        
        private var current: Node<E>?
        
        fileprivate init(_ first: Node<E>?) {
            self.current = first
        }
        
        public mutating func next() -> E? {
            if let item = current?.item {
                current = current?.next
                return item
            }
            return nil
        }
    }
    
    // Returns an iterator that iterates over the items in this bag in reverse order
    public func makeIterator() -> BagIterator<E> {
        return BagIterator<E>(first)
    }
}

extension Bag: CustomStringConvertible {
    public var description: String {
        var str: String = self.reduce(into: "") { $0 += "\($1), " }
        if !self.isEmpty() {
            str.removeLast(2)
        }
        return "[" + str + "]"
    }
}
