//
//  User.swift
//  ACAPO
//
//  Created by Sophie Rego da Cunha Ribeiro on 26/05/16.
//  Copyright © 2016 Diogo Brito. All rights reserved.
//

import Foundation
import CoreData


class User: NSManagedObject {
    
    
    static func addUser(appd:AppDelegate, nome:String, apelido:String, nif:String)
    {
        let appDel:AppDelegate = appd
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let entidade = NSEntityDescription.entityForName("User", inManagedObjectContext: context)
        let novaPessoa = User(entity: entidade!, insertIntoManagedObjectContext: context)
        
        novaPessoa.nome = nome
        novaPessoa.apelido = apelido
        novaPessoa.nif = nif
        
        do
        {
            try
                context.save()
            
        } catch {
            fatalError("Erro ao inserir: \(error)")
        }
    }
    
    // Insert code here to add functionality to your managed object subclass
    static func deleteByNif(appd:AppDelegate, nif:String)
    {
        var lista :Array<AnyObject> = []
        let appDel:AppDelegate = appd
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let fetch = NSFetchRequest(entityName: "User")
        fetch.predicate = NSPredicate(format: "nif == %@", nif)
        do{
            try
                lista = context.executeFetchRequest(fetch)
                for registo in lista{
                    context.deleteObject(registo as! NSManagedObject)
                }
            
        }catch{
            fatalError("Erro ao obter dados\(error)")
        }
    }

}
