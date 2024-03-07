//
//  Nib classes.swift
//  NetworkingLesson
//
//  Created by Nawaf Almutairi on 05/03/2024.
//

import Foundation
import UIKit
import Eureka
import SnapKit
import Kingfisher

class CustomImageView: UIView {
    
    private let imageView = UIImageView()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        // Add imageView to the view hierarchy
        let imageView = UIImageView()
        let url = URL(string: "https://example.com/image.png")
        imageView.kf.setImage(with: url)
        addSubview(imageView)
        
        // Setup imageView constraints using SnapKit
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview() // Center imageView in the UIView
            make.size.equalToSuperview().multipliedBy(0.8) // Make imageView's size 80% of its superview
        }
        
        // Configure the imageView, e.g., with a default image
        imageView.image = UIImage(named: "codedLogo")
        imageView.contentMode = .scaleAspectFit // Adjust the content mode as needed
    }
}
