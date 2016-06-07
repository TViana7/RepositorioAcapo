//
//  LaunchFile.swift
//  ACAPO
//
//  Created by Sophie Rego da Cunha Ribeiro on 31/05/16.
//  Copyright © 2016 Diogo Brito. All rights reserved.
//

import UIKit
import CoreData

class LaunchFile: UIViewController
{
    var connected:Bool?
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    var counter:Int = 0 {
        didSet{
            let fractionalProgress = Float(counter) / 100.0
            let animated = counter != 0
            
            progressView.setProgress(fractionalProgress, animated: animated)
            progressLabel.text = ("\(counter)%")
        }
    }
    
    override func viewDidLoad()
    {
        print("$$ LaunchFile")
        super.viewDidLoad()
        progressView.setProgress(0, animated: true)
        
        if(Reachability.isConnectedToNetwork())
        {
            print("Connected")
            connected=true
            getCaminhos()
            //getPassadeiras()
        }
        else
        {
            print("Not Connected")
            connected=false
        }
        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func getCaminhos()
    {
        
        progressLabel.text = "0%"
        self.counter = 0
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let url = NSURL(string: "http://pmdm.comxa.com/get_path_t.php?t=1")!
        let request = NSURLRequest(URL: url)
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            guard error == nil else
            {
                print("Erro ao invocar o GET de t=1")
                print(error)
                return
            }
            
            guard let respData = data else
            {
                print("Erro: Dados não recebidos")
                return
            }
            
            do
            {
                guard let json = try?  NSJSONSerialization.JSONObjectWithData(data!, options: []) else
                {
                    print("Erro na conversão para JSON")
                    return
                }
                
                if let response = response as? NSHTTPURLResponse where 200...209 ~= response.statusCode {
                    if let posts = json["posts"] as? [[String: AnyObject]]{
                        for p in posts{
                            guard let idC = p["post"]!["id_caminho"] as? String else{
                                print("Erro ao obter o id")
                                return
                            }
                            guard let nomeC = p["post"]!["nome_caminho"] as? String else{
                                print("Erro ao obter o nome")
                                return
                            }
                            guard let tipoC = p["post"]!["tipo_caminho"] as? String else{
                                print("Erro ao obter o tipo")
                                return
                            }
                            guard let corC = p["post"]!["cor_caminho"] as? String else{
                                print("Erro ao obter a cor")
                                return
                            }
                            guard let dateC = p["post"]!["data_caminho"] as? String else{
                                print("Erro ao obter a data")
                                return
                            }
                            guard let descC = p["post"]!["descricao_caminho"] as? String else{
                                print("Erro ao obter a descrição")
                                return
                            }
                            guard let encodeC = p["post"]!["encode_caminho"] as? String else{
                                print("Erro ao obter o encode")
                                return
                            }
                            
                            let idCa = NSNumber(integer: Int(idC)!)
                            let tipoCa = NSNumber(integer: Int(tipoC)!)
                            
                            if(!CaminhosPe.caminhoExiste(appDel, id: idCa))
                            {
                                CaminhosPe.addCaminho(appDel, idC: idCa, nomeC: nomeC, tipoC: tipoCa, corC: corC, dataC: dateC, descC: descC, encodeC: encodeC)
                                print("------------ Caminho \(nomeC) inserido ----------------")
                            }
                            
                            if(CaminhosPe.dataMudou(appDel, id: idCa, date: dateC))
                            {
                                CaminhosPe.deleteByID(appDel, id: idCa)
                                print("------ Caminho Eleminado -------")
                                CaminhosPe.addCaminho(appDel, idC: idCa, nomeC: nomeC, tipoC: tipoCa, corC: corC, dataC: dateC, descC: descC, encodeC: encodeC)
                                print("----- Caminho alterado adicionado --------")
                            }
                            
                            print("-- Caminho \(nomeC) não adicionado")
                            
                            dispatch_async(dispatch_get_main_queue())
                            {
                                if(self.counter<50){
                                    self.counter++
                                }
                            }
                            
                            
                        }
                        
                        if(self.counter != 50){
                            self.counter=50
                        }
                        
                        self.getPassadeiras()
                        
                    }
                }
            }
        })
        print("task caminhos begin")
        task.resume()
        print("task caminhos finish")
        
    }
    
    func getPassadeiras()
    {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let url = NSURL(string: "http://pmdm.comxa.com/select_passadeira.php")!
        let request = NSURLRequest(URL: url)
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            guard error == nil else
            {
                print("Erro ao invocar o GET de t=1")
                print(error)
                return
            }
            
            guard let respData = data else
            {
                print("Erro: Dados não recebidos")
                return
            }
            
            do
            {
                guard let json = try?  NSJSONSerialization.JSONObjectWithData(data!, options: []) else
                {
                    print("Erro na conversão para JSON")
                    return
                }
                
                if let response = response as? NSHTTPURLResponse where 200...209 ~= response.statusCode {
                    if let posts = json["posts"] as? [[String: AnyObject]]{
                        for p in posts{
                            guard let idP = p["post"]!["id_passadeira"] as? String else{
                                print("Erro ao obter o id")
                                return
                            }
                            guard let nomeP = p["post"]!["nome_passadeira"] as? String else{
                                print("Erro ao obter o nome")
                                return
                            }
                            guard let dateP = p["post"]!["data_passadeira"] as? String else{
                                print("Erro ao obter a data")
                                return
                            }
                            guard let descP = p["post"]!["descricao_passadeira"] as? String else{
                                print("Erro ao obter a descrição")
                                return
                            }
                            guard let encodeP = p["post"]!["encode_passadeira"] as? String else{
                                print("Erro ao obter o encode")
                                return
                            }
                            
                            let idPa = NSNumber(integer: Int(idP)!)
                            
                            Passadeiras.addPassadeira(appDel, idP: idPa, nomeP: nomeP, dataP: dateP, descP: descP, encodeP: encodeP)
                            print("------------ Passadeira \(nomeP) inserido ----------------")
                            
                            
                            dispatch_async(dispatch_get_main_queue())
                                {
                                    if(self.counter>50 && self.counter<100){
                                        self.counter++
                                    }
                            }
                            
                            
                        }
                        if(self.counter != 100){
                            self.counter=100
                        }
                        sleep(2)
                        self.performSegueWithIdentifier("SegueTable", sender: self)
                    }
                }
            }
        })
        print("task passadeiras begin")
        task.resume()
        print("task passadeiras finish")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "SegueTable")
        {
            let viewC:ViewController = (segue.destinationViewController as! ViewController)
            viewC.isConnected=connected
        }
    }
}