//
//  PriceManager.swift
//  IOS_Senin_3_ist
//
//  Created by Jenya on 29.01.2021.
//

import UIKit
import StoreKit


let APPSTORE_PURCHASE = "LocationNotes.FullVersion"

var fullVersionProduct: SKProduct?

class PriceManager: NSObject {

        
    func getPriceForProduct(idProduct: String) {
        
        if SKPaymentQueue.canMakePayments() {
            print("Невозможно делать покупки")
            return
        }
        
        let request = SKProductsRequest(productIdentifiers: [idProduct])
        request.delegate = self
        request.start()
        
    }
}

extension PriceManager: SKProductsRequestDelegate
{
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        if response.invalidProductIdentifiers.count != 0 {
            print("Есть неактуальные продукты: \(response.invalidProductIdentifiers)")
        }
        
        if response.products.count > 0 {
            fullVersionProduct = response.products[0]
            print("Получили продукт: \(String(describing: fullVersionProduct?.localizedTitle)) \(String(describing: fullVersionProduct?.localizedDescription))")
        }
    }
}
