//
//  Tips.swift
//  Grocery
//
//  Created by Apple on 25/08/24.
//

import Foundation
import TipKit

struct InformationTip: Tip{
    
    static let didTriggerControlEvent = Event(id: "didTriggerControlEvent")
    
    var title: Text {
        Text("Know More")
            
    }
    
    var message: Text? {
        Text("Reviews And Product DEscription")
    }
    
    var image: Image? {
        Image(systemName: "info.circle")
            
    }
    
    var actions: [Action] {
        Action(id: "1", title: "Learn More")
    }
    
    var rules: [Rule] {
        
        #Rule(Self.didTriggerControlEvent) {
            $0.donations.count >= 3
        }
    }
}
