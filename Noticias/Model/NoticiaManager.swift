//
//  NoticiaManager.swift
//  Noticias
//
//  Created by Marco Alonso Rodriguez on 29/10/22.
//

import Foundation
import UIKit

protocol NoticiaManagerProcol {
    func mostrarNoticias(arregloNoticias: [Noticia])
}


struct NoticiaManager {
    var delegado: NoticiaManagerProcol?
    
    
    func getNews(topic: String) {
        let urlString = "https://newsapi.org/v2/everything?apiKey=f0797ef3b62d4b90a400ed224e0f82b7&q=\(topic)&language=es"
        
        guard let url = URL(string: urlString) else { return }
        
        let tarea = URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                print("error al obtener notitcias")
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let listaNoticias = try decoder.decode(NoticiaData.self, from: data)
                    let noticias = listaNoticias.articles
                    delegado?.mostrarNoticias(arregloNoticias: noticias)
                } catch {
                    print("Debug: error \(error.localizedDescription)")
                }
            }
        }
        tarea.resume()
    }
    
   
    
    func getImageWithCompletion(urlString: String , completionHandler: @escaping(_ image: UIImage?) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let image = UIImage(data: data),
                  let _ = response else { return }
            completionHandler(image)
        }
        .resume()
    }
}
