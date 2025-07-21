//
//  PaymentManager.swift
//  Grocery
//
//  Created by Sudharshan on 21/07/25.
//

import SwiftUI
import Razorpay

class PaymentManager: ObservableObject {
    
    static let shared = PaymentManager()
    @Published var onResult: Bool?
    
    let razorPayKey = "rzp_test_37SUpjXAwpSfUA"
    var razorpay: RazorpayCheckout!
    
    private init() {}
    
    func intiatePayment(amount: Double) {
        razorpay = RazorpayCheckout.initWithKey(razorPayKey, andDelegate: self)
        
        let options: [String:Any] = [
                    "key": razorPayKey,
                    "amount": "\(Int(amount))00",
                    "currency": "INR",
                    "description": "purchase description",
                    "order_id": "",
                    "image": "https://url-to-image.jpg",
                    "name": "Grocery",
                    "prefill": [
                        "contact": "+919876543210",
                        "email": "gaurav.kumar@example.com"
                    ],
                    "theme": [
                        "color": "#F37254"
                    ]
                ]
        razorpay.open(options)
    }
}

extension PaymentManager: RazorpayPaymentCompletionProtocol {
    
    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
        DispatchQueue.main.async {
            self.onResult = false
        }
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        DispatchQueue.main.async {
            self.onResult = true
        }
        Cart.shared.clearCart()
    }
    
    
}
