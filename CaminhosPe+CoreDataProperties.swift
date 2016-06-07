//
//  CaminhosPe+CoreDataProperties.swift
//  ACAPO
//
//  Created by Sophie Rego da Cunha Ribeiro on 29/05/16.
//  Copyright © 2016 Diogo Brito. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CaminhosPe {

    @NSManaged var encode_caminho: String?
    @NSManaged var descricao_caminho: String?
    @NSManaged var data_caminho: String?
    @NSManaged var cor_caminho: String?
    @NSManaged var nome_caminho: String?
    @NSManaged var id_caminho: NSNumber?
    @NSManaged var tipo_caminho: NSNumber?

}
