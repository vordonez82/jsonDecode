//
//  ViewController.swift
//  bookSearch2
//
//  Created by Vicente Ordoñez Garcia on 12/2/18.
//  Copyright © 2018 Vicente Ordoñez Garcia. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    var ISBN : String? = ""
    
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var txtISBN: UITextField!
    @IBOutlet weak var lblAutor: UILabel!
    @IBOutlet weak var imgPortada: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lblTitulo.text = ""
        lblAutor.text = ""
        
        txtISBN.delegate=self
    }

    @IBAction func textFieldDidEndEditing(_ textField: UITextField) {
        ISBN = txtISBN.text
        lblTitulo.text = "Buscando..."
        if ISBN != ""
        {
            //sincrono(isbn: ISBN!)
            asincrono(isbn: ISBN!)
        }
        textField.resignFirstResponder()
    }
    
    func sincrono(isbn : String) {
        do {
            let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + isbn
            let url = try NSURL(string: urls)
            let datos:NSData? = try NSData(contentsOf: url! as URL)
            let texto = try NSString(data: datos! as Data, encoding: String.Encoding.utf8.rawValue)
            if texto != "{}" {
                //txtResult.text = texto! as String
            }
            else {
                lblTitulo.text = "No se encontraron resultados"
                //txtResult.text = "No se encontraron coincidencias"
            }
        }
        catch {
            //Handle the error
            var alert = UIAlertView(title:"No internet connection", message: "No hay conexion a internet", delegate: nil, cancelButtonTitle: "OK")
        }
    }
    
    func asincrono(isbn:String) {
        var title: String = ""
        var autores : String = ""
        var imageURL : String = ""
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + isbn
        //let urls = "https://restcountries.eu/rest/v2/all"
        let url =  URL(string: urls)
        let datos = NSData(contentsOf: url!)
        do {
            let jsonR = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            
            let dic1 = jsonR as! NSDictionary
            let dic2 = dic1["ISBN:"+isbn] as! NSDictionary
            title = dic2["title"] as! String
            
            let dictCovers = dic2["cover"] as! NSDictionary
            imageURL = dictCovers["medium"] as! String
            
            let urlImage = URL(string: imageURL)
            DispatchQueue.global(qos: .userInitiated).async {
                
                let imageData:NSData = NSData(contentsOf: urlImage!)!
                
                // When from background thread, UI needs to be updated on main_queue
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.imgPortada.image = image
                    self.imgPortada.contentMode = UIView.ContentMode.scaleAspectFit
                    
                }
            }
            
            let authors = dic2.object(forKey: "authors") as! [[String:AnyObject]]
            for author in authors {
                if let userValues = author["name"] as? String
                {
                    //print(userValues)
                    autores += userValues + ", "
                }
            }
        }
        catch _ {
            
        }
        
        lblTitulo.text = title
        lblAutor.text = autores
        
        /*
        
        let session = URLSession.shared
        
        session.dataTask(with: url) {
            (data, response, error) in
            if (error != nil) {
                print(error!.localizedDescription)
                self.lblTitulo.text = error!.localizedDescription
            }
            guard let json = data else { return }
            let texto =  NSString(data: json as Data, encoding: String.Encoding.utf8.rawValue)
            if texto != "{}" {
                do {
                    let jsonR = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves)
                    
                    let dic1 = jsonR as! NSDictionary
                    let dic2 = dic1["ISBN:"+isbn] as! NSDictionary
                    
                    //print(texto!)
                    //var bookResult = try JSONDecoder().decode([Countries].self, from: data!)
                    //print(bookResult.book.title)
                    //for country in bookResult {
                    //    print(country.name)
                    //}
                    //self.lblTitulo.text = texto! as String
                }
                catch {
                    print(error.localizedDescription)
                    self.lblTitulo.text = error.localizedDescription
                }
            }
            else {
                self.lblTitulo.text = "No se encontraron coincidencias"
                
            }
            }.resume()
         */
    }
 
}

