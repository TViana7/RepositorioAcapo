//
//  Passadeiras.swift
//  ACAPO
//
//  Created by Sophie Rego da Cunha Ribeiro on 03/06/16.
//  Copyright © 2016 Diogo Brito. All rights reserved.
//

import Foundation
import CoreData


class Passadeiras: NSManagedObject {

    static func addPassadeira(appd:AppDelegate, idP:NSNumber, nomeP:String, dataP:String, descP:String, encodeP:String)
    {
        let appDel:AppDelegate = appd
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let entidade = NSEntityDescription.entityForName("Passadeiras", inManagedObjectContext: context)
        let novaPassadeira = Passadeiras(entity: entidade!, insertIntoManagedObjectContext: context)
        
        novaPassadeira.id_passadeira = idP
        novaPassadeira.nome_passadeira = nomeP
        novaPassadeira.descricao_passadeira = descP
        novaPassadeira.data_passadeira = dataP
        novaPassadeira.encode_passadeira = encodeP
        
        do
        {
            try
                context.save()
            
        } catch {
            fatalError("Erro ao inserir: \(error)")
        }
    }

}
