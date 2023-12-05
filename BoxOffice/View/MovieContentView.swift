//
//  MovieContentView.swift
//  BoxOffice
//
//  Created by jyubong on 12/5/23.
//

import UIKit

class MovieContentView: UIView, UIContentView {
    private var rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        return label
    }()
    
    private var rankFluctuationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
            
        return label
    }()
    
    private lazy var rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.backgroundColor = .systemRed
        
        stackView.addArrangedSubview(rankLabel)
        stackView.addArrangedSubview(rankFluctuationLabel)
        return stackView
    }()
    
    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
            
        return label
    }()
    
    private var audienceCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
            
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

    var configuration: UIContentConfiguration {
        didSet {
            apply(configuration as! MovieContentConfiguration)
        }
    }
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        autoLayout()
        apply(configuration as! MovieContentConfiguration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        addSubview(rankStackView)
        addSubview(movieStackView)
        
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 30),
            rankStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 10),
            rankStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -10),

            movieStackView.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
            movieStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 20),
            movieStackView.trailingAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func apply(_ configuration: MovieContentConfiguration) {
        rankLabel.text = configuration.rank
        rankFluctuationLabel.text = configuration.rankFluctuation
        movieNameLabel.text = configuration.movieName
        audienceCountLabel.text = "오늘 \(configuration.audienceCount!)명 / 총 \(configuration.audienceAccumulation!)명"
    }
}
