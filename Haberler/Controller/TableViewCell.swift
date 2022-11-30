//
//  TableViewCell.swift
//  Haberler
//
//  Created by Berkay ÜÇER on 27.11.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var photoview: UIImageView!
    @IBOutlet weak var headLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}



extension UIImageView {
    func loadFrom(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        let size = CGSize(width: self.bounds.width, height: self.bounds.height)
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                let renderer = UIGraphicsImageRenderer(size: size)
                let scaledImage = renderer.image { _ in
                    image!.draw(in: CGRect(origin: .zero, size: size))
                }
                self.image = scaledImage
            }
        }
    }
}
