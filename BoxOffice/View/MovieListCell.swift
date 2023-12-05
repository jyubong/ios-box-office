//
//  MovieListCell.swift
//  BoxOffice
//
//  Created by Kiseok on 12/5/23.
//

import UIKit

class MovieListCell: UICollectionViewListCell {
    var movie: DailyBoxOfficeList!
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        let configuaration = MovieContentConfiguration().updated(for: state)
        configuaration.rank = movie.rank
        configuaration.rankFluctuation = movie.rankFluctuation
        configuaration.movieName = movie.movieName
        configuaration.audienceCount = movie.audienceCount
        configuaration.audienceAccumulation = movie.audienceAccumulation
        
        contentConfiguration = configuaration
    }
    
}
