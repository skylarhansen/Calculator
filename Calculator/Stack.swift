//
//  Stack.swift
//  Calculator
//
//  Created by Skylar Hansen on 5/30/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class Stack {
    
    private var floatsArray: [Float] = []
    
    func pop() -> Float? {
        return floatsArray.removeLast()
    }
    
    func push(float: Float) {
        floatsArray.append(float)
    }
    
    func log() {
        print(floatsArray)
    }
    
    func count() -> Int {
        return floatsArray.count
    }
}