//
//  OneTestViewController.swift
//  TZ_Project
//
//  Created by Felix Falkovsky on 20.07.2020.
//  Copyright © 2020 Felix Falkovsky. All rights reserved.
//

import UIKit

class OneTestViewController: UIViewController {

    var dataDZ: DetailData!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var ladelDescription: UILabel!
    @IBOutlet weak var labelDetailText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.text = dataDZ.name
        ladelDescription.text = dataDZ.data
        labelDetailText.text = "\(String(describing: dataDZ.selectedId))"
     
        if URL(string: dataDZ.url ?? "url") != nil {
            if let data = try? Data(contentsOf: URL(string: dataDZ.url!)!) {
                imageView.image = UIImage(data: data)
            }
        }
    }
}
