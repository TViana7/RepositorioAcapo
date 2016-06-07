//
//  User+CoreDataProperties.swift
//  ACAPO
//
//  Created by Sophie Rego da Cunha Ribeiro on 26/05/16.
//  Copyright © 2016 Diogo Brito. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var nome: String?
    @NSManaged var apelido: String?
    @NSManaged var nif: String?

}
