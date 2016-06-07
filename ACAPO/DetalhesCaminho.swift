//
//  DetalhesCaminho.swift
//  ACAPO
//
//  Created by Sophie Rego da Cunha Ribeiro on 30/05/16.
//  Copyright © 2016 Diogo Brito. All rights reserved.
//

import UIKit
import CoreData

class DetalhesCaminho: UIViewController
{
    
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblNome: UILabel!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblTipo: UILabel!
    @IBOutlet weak var lblCor: UILabel!
    @IBOutlet weak var tfDesc: UITextView!
    
    var caminho:CaminhosPe?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        lblID.text = String(caminho!.id_caminho!)
        lblNome.text = caminho!.nome_caminho
        lblData.text = caminho!.data_caminho
        lblTipo.text = String(caminho!.tipo_caminho!)
        lblCor.text = caminho!.cor_caminho
        tfDesc.text = caminho!.descricao_caminho
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
