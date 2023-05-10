//
//  ViewController.swift
//  Noticias
//
//  Created by Marco Alonso Rodriguez on 29/10/22.
//

import UIKit
import Kingfisher
import SafariServices

class NoticiasViewController: UIViewController, NoticiaManagerProcol, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var topicNoticia: UITextField!
    
    @IBOutlet weak var tablaNoticias: UITableView!
    var listaNoticias = [Noticia]() // var articuloNoticias: [Noticia] = []
    
    var manager = NoticiaManager()
    var urlSitioWeb: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicNoticia.delegate = self
        //registrar la nueva celda
        tablaNoticias.register(UINib(nibName: "NoticiaCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        tablaNoticias.delegate = self
        tablaNoticias.dataSource = self
        
        manager.delegado = self
        manager.getNews(topic: "futbol")
        
    }
    

    //MARK: Método del Protocolo
    func mostrarNoticias(arregloNoticias: [Noticia]) {
        listaNoticias = arregloNoticias
        DispatchQueue.main.async {
            self.tablaNoticias.reloadData()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    private func scrollToTop(){
        let indexPath = IndexPath(row: 0, section: 0)
        tablaNoticias.scrollToRow(at: indexPath, at: .top, animated: true)

    }
    
    @IBAction func topicDefaultNoticias(_ sender: UISegmentedControl) {
        
        scrollToTop()
        
        var topic = ""
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        switch sender.selectedSegmentIndex {
        case 0:
            topic = "\(sender.titleForSegment(at: 0)!)"
        case 1:
            topic = "\(sender.titleForSegment(at: 1)!)"
        case 2:
            topic = "\(sender.titleForSegment(at: 2)!)"
        case 3:
            topic = "\(sender.titleForSegment(at: 3)!)"
        case 4:
            topic = "\(sender.titleForSegment(at: 4)!)"
            
        default:
            topic = "musica"
        }
        
        manager.getNews(topic: topic)
            
    }
    
    
    //MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaNoticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)  -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! NoticiaCell
        
        celda.setupCelda(noticia: listaNoticias[indexPath.row])
        
        return celda
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        urlSitioWeb = listaNoticias[indexPath.row].url
        guard let url = URL(string: urlSitioWeb ?? "") else { return }
        let vcSS = SFSafariViewController(url: url)
        present(vcSS, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verPaginaWeb" {
            let paginWeb = segue.destination as! PaginaWebViewController
            paginWeb.recibirSitioWeb = urlSitioWeb ?? ""
        }
    }
}

//MARK: UITextFieldDelegate
extension NoticiasViewController: UITextFieldDelegate {
    //1.- Habilitar el boton del teclado virtual
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Hacer algo ")
        //ocultar teclado
        textField.endEditing(true)
        return true
    }
    
    //2.- Identificar cuando el usuario termina de editar y que pueda borrar el contenido del textField
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollToTop()
        if textField.text!.count > 2 {
            let topic = textField.text!.replacingOccurrences(of: " ", with: "%20").folding( options: .diacriticInsensitive,locale: .current)
            manager.getNews(topic: topic)
            print("Debug: topic \(topic)")

        }
        textField.text = ""
        textField.endEditing(true)
    }
    
    
    
    //3.- Evitar que el usuario no escriba nada
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            //el usuario no escribio nada
            mostrarAlerta(titulo: "Atención", mensaje: "Escribe un tema para buscar noticias relacionadas (Ejemplo: clima)")
            return false
        }
    }
    
    func mostrarAlerta(titulo: String, mensaje: String) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let accionAceptar = UIAlertAction(title: "OK", style: .default) { _ in
            //Do something
        }
        alerta.addAction(accionAceptar)
        present(alerta, animated: true)
    }
}
