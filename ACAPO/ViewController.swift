//
//  ViewController.swift
//  ACAPO
//
//  Created by Sophie Rego da Cunha Ribeiro on 26/05/16.
//  Copyright © 2016 Diogo Brito. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    
    
    var array=[CaminhosPe]()
    var caminhoSelecionado:CaminhosPe?
    var isConnected:Bool?
    
    override func viewDidLoad() {
        print("$$ ViewController")
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        getData()
        if(isConnected == false)
        {
            let alert = UIAlertController(title: "Sem net", message: "Sincronização impossivel, os dados locais vão ser usados", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnFromRefresh(sender: AnyObject)
    {
        getData()
        print("refresh")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        let color1:UIColor = hexStringToUIColor(array[indexPath.row].cor_caminho!)
        cell.backgroundColor = color1
        cell.textLabel?.text = array[indexPath.row].nome_caminho
        
        return cell
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let detalhes = UITableViewRowAction(style: .Default, title:"Detalhes"){ action,index in
            print("Detalhes")
            self.caminhoSelecionado = self.array[indexPath.row]
            self.performSegueWithIdentifier("SegueDetalhes", sender: self)
        }
        detalhes.backgroundColor=UIColor.blueColor()
        
        /*let apagar = UITableViewRowAction(style: .Default, title: "Apagar"){ action, index in
            print("apagar\(index)")
            let appDel:AppDelegate=UIApplication.sharedApplication().delegate as! AppDelegate
            //User.deleteByNif(appDel, nif: self.array[indexPath.row].nif!)
            self.getData()
            self.table.reloadData()
        }*/
        
        return[detalhes]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.caminhoSelecionado = self.array[indexPath.row]
        self.performSegueWithIdentifier("SegueMaps", sender: self)
    }
    
    func getData()
    {
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let fetch = NSFetchRequest(entityName: "CaminhosPe")
        
        do {
            try
                array = context.executeFetchRequest(fetch) as! [CaminhosPe]
        } catch{
            fatalError("Erro ao obter dados: \(error)")
        }
        
        print("numero de resultados devolvidos \(array.count)")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "SegueDetalhes")
        {
            let detalhesController:DetalhesCaminho = (segue.destinationViewController as! DetalhesCaminho)
            detalhesController.caminho = caminhoSelecionado
            
        }else if(segue.identifier == "SegueMaps")
        {
            let mapsController:MapsController = (segue.destinationViewController as! MapsController)
            mapsController.caminho = caminhoSelecionado
        }
        
        
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

