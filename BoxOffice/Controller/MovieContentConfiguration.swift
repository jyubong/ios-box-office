//
//  MovieContentConfiguration.swift
//  BoxOffice
//
//  Created by jyubong on 12/5/23.
//

import UIKit

class MovieContentConfiguration: UIContentConfiguration {
    var rank: String?
    var rankFluctuation: String?
    var movieName: String?
    var audienceCount: String?
    var audienceAccumulation: String?
    
    func makeContentView() -> UIView & UIContentView {
        return MovieContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
}
