//
//  MapsController.swift
//  ACAPO
//
//  Created by Sophie Rego da Cunha Ribeiro on 01/06/16.
//  Copyright © 2016 Diogo Brito. All rights reserved.
//

import UIKit
import CoreData
import MapKit


class MapsController:UIViewController, MKMapViewDelegate
{
    var lat:Int=0
    var lng:Int=0
    var caminho:CaminhosPe?
    var array=[Passadeiras]()
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print("$$ Maps")
        print("Caminho \((caminho?.nome_caminho)!) - Encode: \((caminho?.encode_caminho)!)")
        
        initCaminho()
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer!
    {
        if overlay is MKPolyline
        {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            let color:UIColor = hexStringToUIColor((caminho?.cor_caminho)!)
            polylineRenderer.strokeColor = color
            polylineRenderer.lineWidth = 7
            return polylineRenderer
        }
        
        return nil
        
    }
    
    func initCaminho()
    {
        var poly = Polyline(encodedPolyline:caminho!.encode_caminho!)
        let coord:[CLLocationCoordinate2D]? = poly.coordinates!
        var coordinates: [CLLocationCoordinate2D] = []
        let tam = coord!.count-1
        for index in 0...tam{
            let coordinatesToAppend = CLLocationCoordinate2D(latitude: coord![index].latitude, longitude: coord![index].longitude)
            coordinates.append(coordinatesToAppend)
        }
        
        let polyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)
        //print("polyline: \(polyline)")
        
        
        let latitude:CLLocationDegrees = coord![0].latitude
        let longitude:CLLocationDegrees = coord![0].longitude
        print("Latitude: \(latitude) | Longitude: \(longitude)")
        
        let latDelta:CLLocationDegrees = 0.99999999
        let longDelta:CLLocationDegrees = 0.99999999
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.mapType = .Standard
        map.setRegion(region, animated: true)
        map.showsBuildings=true
        map.scrollEnabled=true
        map.addOverlay(polyline)
        
        let distance: CLLocationDistance = 1
        let pitch: CGFloat = 85
        let heading = 90.0
        let c = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let camera = MKMapCamera(lookingAtCenterCoordinate: c,
            fromDistance: distance,
            pitch: pitch,
            heading: heading)
        
        map.camera = camera
        
        /*
         * Passadeiras
         */
        getPassadeiras()
        
        let tamArray = array.count-1
        for p in 0...tamArray
        {
            let point = MKPointAnnotation()
            poly = Polyline(encodedPolyline:array[p].encode_passadeira!)
            let coordinate:[CLLocationCoordinate2D]? = poly.coordinates!
            //print("Coordinate: \(coordinate!)")
            let tamP=coordinate!.count-1
            for i in 0...tamP{
                point.coordinate = CLLocationCoordinate2D(latitude: coordinate![i].latitude, longitude: coordinate![i].longitude)
                point.title = array[p].nome_passadeira!
                map.addAnnotation(point)
            }
            print("Passadeira \(array[p].nome_passadeira!) added to map")
        }
        
    }
    
    func getPassadeiras()
    {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let fetch = NSFetchRequest(entityName: "Passadeiras")
        
        do {
            try
                array = context.executeFetchRequest(fetch) as! [Passadeiras]
        } catch{
            fatalError("Erro ao obter dados: \(error)")
        }
        
        print("numero de resultados devolvidos \(array.count)")
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
