//
//  DoubleLinkedList.swift
//  DataStructure
//
//  Created by limyunhwi on 2022/02/11.
//
import Foundation

class Node {
    var data: Any
    weak var leftLink: Node?
    weak var rightLink: Node?
    
    init(data: Character) {
        self.data = data
    }
}

class DoubleLinkedList {
    var head: Node?
    var tail: Node?
    var first: Node? {return head}
    var last: Node? {return tail}
    var isEmpty: Bool {return head == nil}
    var count: Int = 0
    
    func append(_ newNode: Node) {
        count += 1
        
        //빈 리스트가 아닌 경우
        if var tail = tail {
            tail.rightLink = newNode
            newNode.leftLink = tail
            tail = newNode
            return
        }
        //빈 리스트인 경우
        head = newNode
        tail = newNode
        return
    }
    
    func insert(_ newNode: Node, index: Int) { //인덱스는 0부터 시작한다.
        guard let nextNode = searchFront(at: index) else {return}
        count += 1
        
        //첫 번째에 삽입하는 경우
        if newNode.leftLink == nil {
            newNode.leftLink = newNode
            newNode.rightLink = newNode
            head = newNode
            
            return
        }
        
        //중간에 삽입하는 경우
        guard let previousNode = nextNode.leftLink else {return}
        newNode.rightLink = nextNode
        newNode.leftLink = previousNode
        nextNode.leftLink = newNode
        previousNode.rightLink = newNode
    }
    
    //앞에서부터 검색해 해당 인덱스의 Node 반환
    func searchFront(at index: Int) -> Node? {//인덱스는 0부터 시작한다.
        //빈 리스트인 경우
        guard let head = head else {return nil}
        
        //범위를 벗어난 경우
        if index < 0 || index >= count {
            return nil
        }
        
        //범위 안
        var finder = head
        var currentIndex = 0
        
        while index < currentIndex {
            finder = finder.rightLink!
            currentIndex += 1
        }
        
        return finder
    }
    
    //마지막 원소 지우고 반환하기
    func remove() -> Node? {
        //빈 리스트인 경우
        guard let tail = tail else {return nil}
        
        count -= 1
        let removedNode = tail
        
        //원소가 하나인 경우
        if tail.leftLink == nil {
            self.tail = nil
            self.head = nil
            
            return removedNode
        }
        
        //원소가 여러 개인 경우
        self.tail = tail.leftLink!
        self.tail?.rightLink = nil
        
        return removedNode
    }
}
