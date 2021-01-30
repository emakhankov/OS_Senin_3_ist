//
//  StoreManager.swift
//  IOS_Senin_3_ist
//
//  Created by Jenya on 29.01.2021.
//

import UIKit
import StoreKit


class StoreManager: NSObject {

    static var isFullVersion: Bool {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isFull")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: "isFull")
        }
    }
    
    func buyFullVersion() {
        
        if let fullVersionProduct = fullVersionProduct {
            
            let payment = SKPayment(product: fullVersionProduct)
            SKPaymentQueue.default().add(payment)
            SKPaymentQueue.default().add(self)
        } else {
            
            if SKPaymentQueue.canMakePayments() {
                print("Невозможно делать покупки")
                return
            }
            
            let request = SKProductsRequest(productIdentifiers: [APPSTORE_PURCHASE])
            request.delegate = self
            request.start()
        }
        
    }
    
    func restoreFullVersion()
    {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
        
        
    }
}


extension StoreManager: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .deferred {
                print("transaction is deferred")
            }
            if transaction.transactionState == .failed {
                print("transaction is failed")
                print("Error: \(String(describing: transaction.error?.localizedDescription))")
                queue.finishTransaction(transaction)
                queue.remove(self)
            }
            if transaction.transactionState == .purchased {
                print("transactiomn is purchased")
                if transaction.payment.productIdentifier == APPSTORE_PURCHASE {
                    StoreManager.isFullVersion = true
                }
                queue.finishTransaction(transaction)
                queue.remove(self)
            }
            if transaction.transactionState == .purchasing {
                print("transaction is purchasing")
            }
            if transaction.transactionState == .restored {
                print("transaction is restored")
                if transaction.payment.productIdentifier == APPSTORE_PURCHASE {
                    StoreManager.isFullVersion = true
                }
                queue.finishTransaction(transaction)
                queue.remove(self)
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        
    }
    
    
}


class BuyingForm {
    
    var isNeedToShow: Bool {
        if StoreManager.isFullVersion {
            return false
        }
        if notes.count <= 3 {
            return false
        }
        return true
    }
    
    var storeManager = StoreManager()
    
    func showForm(inController: UIViewController)
    {
        if let fullVersionProduct = fullVersionProduct {
            let alertController = UIAlertController(title: fullVersionProduct.localizedTitle, message: fullVersionProduct.localizedDescription, preferredStyle: .alert)
        
            
            let actionBuy = UIAlertAction(title: "Buy for \(fullVersionProduct.price) \(fullVersionProduct.priceLocale.currencySymbol!)", style: .default) { (action) in
                self.storeManager.buyFullVersion()
            }
            
            let actionRestore = UIAlertAction(title: "Restore", style: .default) { (action) in
                self.storeManager.restoreFullVersion()
            }
            
            let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
                
            }
            
            alertController.addAction(actionBuy)
            alertController.addAction(actionRestore)
            alertController.addAction(actionCancel)
            
            inController.present(alertController, animated: true, completion: nil)
        }
    }
}
extension StoreManager: SKProductsRequestDelegate
{
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        if response.invalidProductIdentifiers.count != 0 {
            print("Есть неактуальные продукты: \(response.invalidProductIdentifiers)")
        }
        
        if response.products.count > 0 {
            fullVersionProduct = response.products[0]
            print("Получили продукт sв storeManager: \(String(describing: fullVersionProduct?.localizedTitle)) \(String(describing: fullVersionProduct?.localizedDescription))")
        
            self.buyFullVersion()
        }
            
    }
}
