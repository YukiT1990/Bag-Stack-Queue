//
//  Queue.swift
//  Datastructure1
//
//  Created by Yuki Tsukada on 2021/03/16.
//

import Foundation

public final class Queue<E> : Sequence {
    private var leastRecent: Node<E>? = nil
    
    // private(set) count
    private(set) var count: Int = 0
    
    fileprivate class Node<E> {
        fileprivate var item: E
        fileprivate var next: Node<E>?
        fileprivate init(item: E, next: Node<E>? = nil) {
            self.item = item
            self.next = next
        }
    }
    
    // init()
    public init() {}
    
    // isEmpty() -> Bool
    public func isEmpty() -> Bool {
        return leastRecent == nil
    }
    
    // enqueue(item: E)
    /* add an item */
    public func enqueue(item: E) {
        if self.isEmpty() {
            leastRecent = Node<E>(item: item, next: nil)
            count += 1
        } else {
            let oldLeastRecent = leastRecent
            while leastRecent?.next != nil {
                leastRecent = leastRecent?.next
            }
            leastRecent?.next = Node<E>(item: item, next: nil)
            count += 1
            
            leastRecent = oldLeastRecent
        }
    }
    
    // dequeue() -> E?
    /* removes and returns the item least recently added to the queue */
    public func dequeue() -> E? {
        if let oldLeastRecent = leastRecent {
            leastRecent = oldLeastRecent.next
            count -= 1
            return oldLeastRecent.item
        } else {
            return leastRecent?.item
        }
    }
    
    // peek() -> E?
    /* returns (but does not remove) the item least recently added to the queue. */
    public func peek() -> E? {
        if let oldLeastRecent = leastRecent {
            return oldLeastRecent.item
        } else {
            return leastRecent?.item
        }
    }
    
    // makeIterator() -> QueueIterator<E>
    public struct QueueIterator<E> : IteratorProtocol {
        public typealias Element = E
        
        private var current: Node<E>?
        
        fileprivate init(_ top: Node<E>?) {
            self.current = top
        }
        
        public mutating func next() -> E? {
            if let item = current?.item {
                current = current?.next
                return item
            }
            return nil
        }
    }
    
    public func makeIterator() -> QueueIterator<E> {
        return QueueIterator<E>(leastRecent)
    }
    
}

extension Queue: CustomStringConvertible {
    public var description: String {
        var str: String = self.reduce(into: "") { $0 += "\($1), " }
        if !self.isEmpty() {
            str.removeLast(2)
        }
        return "[" + str + "]"
    }
}
