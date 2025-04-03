//
//  bButton.swift
//  bench
//
//  Created by gwh on 2025/3/16.
//

import Foundation

extension UIButton {
    @objc static func b_backButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.setTitle("←", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

}
