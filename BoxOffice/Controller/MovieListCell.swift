//
//  MovieListCell.swift
//  BoxOffice
//
//  Created by Kiseok on 12/5/23.
//

import UIKit

class MovieListCell: UICollectionViewListCell {
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
        stackView.alignment = .center
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
        stackView.alignment = .fill
        stackView.addArrangedSubview(movieNameLabel)
        stackView.addArrangedSubview(audienceCountLabel)
        
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.addArrangedSubview(rankStackView)
        stackView.addArrangedSubview(movieStackView)
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.accessories = [.disclosureIndicator()]
        addSubview(stackView)
        
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabelText(_ movie: DailyBoxOfficeList) {
        rankLabel.text = movie.rank
        if movie.rankOldAndNew == RankOldAndNew.new {
            rankFluctuationLabel.text = "신작"
        }
        
        if movie.rankFluctuation.hasPrefix("-") {
            rankFluctuationLabel.attributedText = NSMutableAttributedString()
                .blueHighlight("▼")
                .regular(string: movie.rankFluctuation.trimmingCharacters(in: ["-"]), fontSize: 14)
        } else if movie.rankFluctuation == "0" {
            rankFluctuationLabel.text = movie.rankFluctuation
        } else {
            rankFluctuationLabel.attributedText = NSMutableAttributedString()
                .redHighlight("▲")
                .regular(string: movie.rankFluctuation, fontSize: 14)
        }

        movieNameLabel.text = movie.movieName
        audienceCountLabel.text = "오늘 \(movie.audienceCount)명 / 총 \(movie.audienceAccumulation)명"
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -30),
            rankStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
        ])
    }
}

extension NSMutableAttributedString {

    var fontSize: CGFloat {
        return 14
    }
    var boldFont: UIFont {
        return UIFont(name: "AvenirNext-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }
    var normalFont: UIFont {
        return UIFont(name: "AvenirNext-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }

    func bold(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    func regular(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    func redHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.red
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func blueHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.blue

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func underlined(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font: normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
