//
//  Passadeiras+CoreDataProperties.swift
//  ACAPO
//
//  Created by Sophie Rego da Cunha Ribeiro on 03/06/16.
//  Copyright © 2016 Diogo Brito. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Passadeiras {

    @NSManaged var id_passadeira: NSNumber?
    @NSManaged var data_passadeira: String?
    @NSManaged var descricao_passadeira: String?
    @NSManaged var nome_passadeira: String?
    @NSManaged var encode_passadeira: String?

}
