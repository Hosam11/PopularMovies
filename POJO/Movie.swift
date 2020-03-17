//
//  Movie.swift
//  SwiftProject
//
//  Created by MacOSSierra on 3/6/20.
//  Copyright © 2020 MAhmoud. All rights reserved.
//

import Foundation
class Movie{
    var id : String
    var title : String
    var release_date : String
    var vote_average : String
    var overview : String
    var poster_path : String
    var trailers : String
    var Alltrailers = [String]()
    var reviewLink : String
    var AllReviews = [String]()
    

init(id:String,title:String,release_date:String,vote_average:String,overview:String,poster_path:String) {
    self.id=id
    self.title=title
    self.release_date=release_date
    self.overview=overview
    self.vote_average=vote_average
    self.poster_path="http://image.tmdb.org/t/p/"+"original"+poster_path
    self.Alltrailers=[]; self.trailers="https://api.themoviedb.org/3/movie/"+id+"/videos?api_key=d48385912e9ef27b0552871f8b253a6e&language=en-US"
    self.AllReviews=[];
    self.reviewLink="https://api.themoviedb.org/3/movie/"+id+"/reviews?api_key=d48385912e9ef27b0552871f8b253a6e&language=en-US"
    
}

  
}
