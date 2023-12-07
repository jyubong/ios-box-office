//
//  MovieContentView.swift
//  BoxOffice
//
//  Created by jyubong on 12/7/23.
//

import UIKit

class MovieContentView: UIView, UIContentView {
    private var rankLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private var rankFluctuationLabel: UILabel = {
        let label = UILabel()
            
        return label
    }()
    
    private lazy var rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    
    private var movieNameLabel: UILabel = {
        let label = UILabel()
            
        return label
    }()
    
    private var audienceCountLabel: UILabel = {
        let label = UILabel()
            
        return label
    }()
    
    private lazy var movieStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 3
        
        stackView.addArrangedSubview(movieNameLabel)
        stackView.addArrangedSubview(audienceCountLabel)
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        stackView.addArrangedSubview(rankStackView)
        stackView.addArrangedSubview(movieStackView)
        return stackView
    }()
    
    private var currentConfiguration: MovieConfiguration!
    
    var configuration: UIContentConfiguration {
        get {
            return currentConfiguration
        }
        set {
            guard let newConfiguration = newValue as? MovieConfiguration else {
                return
            }
            
            apply(configuration: newConfiguration)
        }
    }
    
    init(configuration: MovieConfiguration) {
        super.init(frame: .zero)
        
        addSubview(rankStackView)
//        addSubview(movieNameLabel)
        autoLayout()
        
//        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            movieNameLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor , constant: 30),
//            movieNameLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 10),
//            movieNameLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -10),
//        ])
        
        apply(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
//        NSLayoutConstraint.activate([
//            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor , constant: 10),
//            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 10),
//            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -10),
//            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            rankStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2)
//        ])
        
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankFluctuationLabel)
        
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor , constant: 10),
            rankStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 10),
            rankStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -10),
            rankStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func apply(configuration: MovieConfiguration) {
        guard currentConfiguration != configuration else {
            return
        }
        
        currentConfiguration = configuration
        
        rankLabel.text = configuration.rank
        rankFluctuationLabel.text = configuration.rankFluctuation
        movieNameLabel.text = configuration.movieName
        audienceCountLabel.text = "오늘 \(configuration.audienceCount!)명 / 총 \(configuration.audienceAccumulation!)명"
    }
}
