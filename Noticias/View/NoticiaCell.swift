//
//  NoticiaCell.swift
//  Noticias
//
//  Created by Marco Alonso Rodriguez on 05/11/22.
//

import UIKit
import Kingfisher

class NoticiaCell: UITableViewCell {

    @IBOutlet weak var tituloNoticia: UILabel!
    
    @IBOutlet weak var backgroundStack: UIStackView!
    @IBOutlet weak var descripcionNoticia: UITextView!
    @IBOutlet weak var imagenNoticia: UIImageView!
    @IBOutlet weak var fechaNoticia: UILabel!
    @IBOutlet weak var fuenteNoticia: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /*
         celda.tituloNoticia.text = listaNoticias[indexPath.row].title
         celda.descripcionNoticia.text = listaNoticias[indexPath.row].description
         celda.fuenteNoticia.text = "Fuente: \(listaNoticias[indexPath.row].source.name ?? "")"
         let fecha = listaNoticias[indexPath.row].publishedAt
         
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd MMM, yyyy"
         
         let dataFromAPI = dateFormatter.date(from: fecha ?? "")
         let date = dateFormatter.string(from: dataFromAPI ?? Date.now)
         
         
         celda.fechaNoticia.text = date
         
         if let url = URL(string: listaNoticias[indexPath.row].urlToImage ?? "") {
             celda.imagenNoticia.kf.setImage(with: url)
         }
         */
    }
    
    func setupCelda(noticia: Noticia) {
        backgroundStack.layer.cornerRadius = 15
        backgroundStack.layer.masksToBounds = true
        tituloNoticia.text = noticia.title
        descripcionNoticia.text = noticia.description
        fuenteNoticia.text = "Fuente: \(noticia.source.name ?? "")"
        let fecha = noticia.publishedAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        
        let dataFromAPI = dateFormatter.date(from: fecha ?? "")
        let date = dateFormatter.string(from: dataFromAPI ?? Date.now)
        fechaNoticia.text = date
        
        if let url = URL(string: noticia.urlToImage ?? "https://www.manoharlalkhattar.in/sites/default/files/pr-placeholder.jpg") {
            imagenNoticia.kf.setImage(with: url)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //Redondear las esquinas
        imagenNoticia.layer.cornerRadius = 15
    }
    
}
