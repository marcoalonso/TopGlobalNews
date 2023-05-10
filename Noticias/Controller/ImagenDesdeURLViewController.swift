//
//  ImagenDesdeURLViewController.swift
//  Noticias
//
//  Created by Marco Alonso Rodriguez on 05/11/22.
//

import UIKit

class ImagenDesdeURLViewController: UIViewController {

    
    @IBOutlet weak var imageToLoad: UIImageView!
    
    
    let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/488px-Apple_logo_black.svg.png")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getImageWithCompletion { image in
            DispatchQueue.main.async {
                self.imageToLoad.image = image
            }
            
        }
    }
    
    func getImageWithCompletion(completionHandler: @escaping(_ image: UIImage?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let image = UIImage(data: data),
                  let _ = response else { return }
            completionHandler(image)
        }
        .resume()
    }

}
