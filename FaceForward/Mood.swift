//
//  Mood.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-19.
//
//

import Foundation

enum Mood: String {
        case great = "Great"
        case good = "Good"
        case average = "Average"
        case bad = "Bad"
        case veryBad = "Very bad"
        
        func toValue() -> Int{
            switch self{
            case.great:
                return 0
            case.good:
                return 1
            case.average:
                return 2
            case.bad:
                return 3
            case.veryBad:
                return 4
            }
        }
    
}