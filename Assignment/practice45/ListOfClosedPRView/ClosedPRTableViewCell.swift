//
//  ProductTableViewCell.swift
//  practice45
//
//  Created by Anish Agarwal on 05/11/22.
//

import UIKit

class ClosedPRTableViewCell: UITableViewCell {

    @IBOutlet weak var prTitleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var closedLabel: UILabel!
    @IBOutlet weak var closedDateLabel: UILabel!
    @IBOutlet weak var userIconImage: UIImageView!
    
    private var imageDownloader = ImageDownloader()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(data: ClosedPRElement) {
        prTitleLabel.isHidden = data.state == nil
        usernameLabel.isHidden = data.user?.login == nil
        
        createdLabel.isHidden = data.createdAt == nil
        createdDateLabel.isHidden = data.createdAt == nil
        
        closedLabel.isHidden = data.closedAt == nil
        closedDateLabel.isHidden = data.closedAt == nil
        
        prTitleLabel.text = data.title
        usernameLabel.text = "Username: " + (data.user?.login ?? "")
        createdLabel.text = "Created At"
        createdDateLabel.text = data.createdAt ?? ""
        closedLabel.text = "Closed At"
        closedDateLabel.text = data.closedAt ?? ""
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            if let url = URL(string: data.user?.avatarURL ?? ""){
                self.imageDownloader.getImage(url: url, onCompletion: { result in
                    switch result {
                    case .success(let data):
                        self.userIconImage.image = UIImage(data: data)
                    case .failure( _):
                        self.userIconImage.image = UIImage(named: Constants.ImagesAssets.defualtImage)
                    }
                })
                
            }
        }
        
    }
    
}
