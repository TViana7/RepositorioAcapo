//
//  CaminhosPe.swift
//  ACAPO
//
//  Created by Sophie Rego da Cunha Ribeiro on 29/05/16.
//  Copyright © 2016 Diogo Brito. All rights reserved.
//

import Foundation
import CoreData


class CaminhosPe: NSManagedObject {

    // Insert code here to add functionality to your managed object subclass
    static func addCaminho(appd:AppDelegate, idC:NSNumber, nomeC:String, tipoC:NSNumber, corC:String, dataC:String, descC:String, encodeC:String)
    {
        let appDel:AppDelegate = appd
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let entidade = NSEntityDescription.entityForName("CaminhosPe", inManagedObjectContext: context)
        let novoCaminho = CaminhosPe(entity: entidade!, insertIntoManagedObjectContext: context)
        
        novoCaminho.id_caminho = idC
        novoCaminho.nome_caminho = nomeC
        novoCaminho.tipo_caminho = tipoC
        novoCaminho.cor_caminho = corC
        novoCaminho.data_caminho = dataC
        novoCaminho.descricao_caminho = descC
        novoCaminho.encode_caminho = encodeC
        
        do
        {
            try
                context.save()
            
        } catch {
            fatalError("Erro ao inserir: \(error)")
        }
    }
    
    static func caminhoExiste(appd:AppDelegate, id:NSNumber) -> Bool
    {
        var lista :Array<AnyObject> = []
        let appDel:AppDelegate = appd
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let fetch = NSFetchRequest(entityName: "CaminhosPe")
        fetch.predicate = NSPredicate(format: "id_caminho == %@", id)
        do{
            try
                lista = context.executeFetchRequest(fetch)
            for registo in lista
            {
                if(registo.id_caminho == id)
                {
                    //print("--------------Registo Caminho Esxite \(registo.id_caminho) | \(id):")
                    //print(registo)
                    return true
                }
            }
            
        }catch{
            fatalError("Erro ao obter dados\(error)")
        }
        return false
    }
    
    
    static func dataMudou(appd:AppDelegate, id:NSNumber, date:String) -> Bool
    {
        var lista :Array<AnyObject> = []
        let appDel:AppDelegate = appd
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let fetch = NSFetchRequest(entityName: "CaminhosPe")
        fetch.predicate = NSPredicate(format: "id_caminho == %@", id)
        do{
            try
                lista = context.executeFetchRequest(fetch)
            for registo in lista{
                if(registo.data_caminho != date)
                {
                    return true
                }
            }
            
        }catch{
            fatalError("Erro ao obter dados\(error)")
        }
        return false
    }
    
    static func deleteByID(appd:AppDelegate, id:NSNumber)
    {
        var lista :Array<AnyObject> = []
        let appDel:AppDelegate = appd
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let fetch = NSFetchRequest(entityName: "CaminhosPe")
        fetch.predicate = NSPredicate(format: "id_caminho == %@", id)
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
