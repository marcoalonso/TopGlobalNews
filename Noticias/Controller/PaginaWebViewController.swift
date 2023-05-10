//
//  PaginaWebViewController.swift
//  Noticias
//
//  Created by Marco Alonso Rodriguez on 05/11/22.
//

import UIKit
import WebKit

class PaginaWebViewController: UIViewController {

    @IBOutlet weak var paginaWeb: WKWebView!
    var recibirSitioWeb: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: recibirSitioWeb) {
            paginaWeb.load(URLRequest(url: url))
        }
        
    }
    



}
