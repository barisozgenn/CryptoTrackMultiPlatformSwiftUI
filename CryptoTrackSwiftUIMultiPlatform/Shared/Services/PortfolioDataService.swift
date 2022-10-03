//
//  PortfolioDataService.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 25.09.2022.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container : NSPersistentContainer
    private let containerName : String = "PortfolioContainer"
    private let entityName : String = "PortfolioEntity"
    
    @Published var entities : [PortfolioEntity] = []
    
    init(){
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            
            if let error = error {
                print("DEBUG: ⚠️ Error loading core data : \(error)")
            }
            
            self.getPortfolio()
        }
    }
    
   
    
    // MARK: PUBLIC SECTION

    func editPortfolio(currency : CryptoCurrency, unitPrice: Double = 0 , amount : Double = 0, trancastionType : String = "b" , crudType : ECrudType){
        
        switch crudType {
            
        case .add:
            addTransaction(currency: currency, unitPrice: unitPrice, amount: amount, trancastionType: trancastionType)
        case .update:
            if let entity = entities.first(where: {$0.coinID == currency.id}) {
                updateTransaction(entity: entity, unitPrice: unitPrice, amount: amount, trancastionType: trancastionType)
            }
        case .delete:
            if let entity = entities.first(where: {$0.coinID == currency.id}) {
                deleteTransaction(entity: entity)
            }
        }
         
    }
    
    public enum ECrudType {
        case add
        case update
        case delete
    }
    // MARK: PRIVATE SECTION
    
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            entities = try container.viewContext.fetch(request)
//           print("DEBUG: ⚠️ entity items: \(entities.count)")
        } catch let error {
            print("DEBUG: ⚠️ Error fetching portfolio entity : \(error)")
        }
    }
    
    private func addTransaction (currency : CryptoCurrency, unitPrice: Double , amount : Double, trancastionType : String){
        
        let entity = PortfolioEntity(context: container.viewContext)
        entity.amount = amount
        entity.unitPrice = unitPrice
        entity.transactionType = trancastionType
        entity.coinID = currency.id
        entity.dateCreated = Date()
        
        applyChanges()
    }
    
    private func updateTransaction(entity: PortfolioEntity, unitPrice: Double , amount : Double, trancastionType : String){
        
        entity.amount = amount
        entity.unitPrice = unitPrice
        entity.transactionType = trancastionType
        
        applyChanges()
    }
   
    private func deleteTransaction(entity: PortfolioEntity){
        
        container.viewContext.delete(entity)
        
        applyChanges()
    }
    
    private func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("DEBUG: ⚠️ Error saving entity : \(error)")
        }
    }
    
    private func applyChanges(){
        save()
        getPortfolio()
    }
}
