//
//  CoreDataOperation.swift
//  MovieProject
//
//  Created by MacOSSierra on 3/11/20.
//  Copyright © 2020 HOS. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class CoreDataOperation {


   var manageContext : NSManagedObjectContext? = nil
    
    var moviesNSObjectList : [NSManagedObject] = [NSManagedObject]()
    //var reviewsList  = [String]()
    //var trailersList = [String]()
    // var movieList : [Movie] = []
    
    
    func convNSMOToArrOfMoviesToMovie(NSMArOfMovie: [NSManagedObject]) -> Movie {
        let m : Movie =  Movie(id: "",title: "",release_date: "",vote_average: "",overview: "",poster_path: "");
        
        for ele in NSMArOfMovie {
            m.id = (ele.value(forKey: "id") as! String)
            m.poster_path = (ele.value(forKey: "posterPath") as! String)
            m.overview = (ele.value(forKey: "overview") as! String)
            m.vote_average = (ele.value(forKey: "voteAvg") as! String)
            m.release_date = (ele.value(forKey: "releaseData") as! String)
            m.title = (ele.value(forKey: "title") as! String)
            //var aMovie : NSManagedObject
            // single MovieEntity
            let  aMovie = ele as! MovieEntity
           // ovieEntity can have more than one Trailer
            for item in aMovie.hasTrilersLink!
            {
                let aTrailerEntity = item as! TrailerLinksEntity
                let singleTrailer = aTrailerEntity.trailer
                // print(singleTrailer!)
                m.Alltrailers.append(singleTrailer!)
                // print( "cunt of allT  \(m.Alltrailers.count)");
            }
            // a MovieEntity can have more than one Reviews
            for item in aMovie.hasReviewsLink!
            {
                let aReviewEntity = item as! ReviewLinksEntity
                let singleReview = aReviewEntity.review
                //print(singleReview!)
                m.AllReviews.append(singleReview!)
                // print("cunt of allT  \(m.Alltrailers.count)")
            }
        }
        return m;
    }
    
    func convNSMOToArrOfMoviesToMovie1(NSMArOfMovie: [NSManagedObject]) -> Movie {
        let m : Movie =  Movie(id: "",title: "",release_date: "",vote_average: "",overview: "",poster_path: "");
        
        for ele in NSMArOfMovie {
            m.id = (ele.value(forKey: "id") as! String)
            m.poster_path = (ele.value(forKey: "posterPath") as! String)
            m.overview = (ele.value(forKey: "overview") as! String)
            m.vote_average = (ele.value(forKey: "voteAvg") as! String)
            m.release_date = (ele.value(forKey: "releaseData") as! String)
            m.title = (ele.value(forKey: "title") as! String)
            //var aMovie : NSManagedObject
            // single MovieEntity
            let  aMovie = ele as! MovieEntity1
            // ovieEntity can have more than one Trailer
            for item in aMovie.hasTrilersLink!
            {
                let aTrailerEntity = item as! TrailerLinksEntity
                let singleTrailer = aTrailerEntity.trailer
                // print(singleTrailer!)
                m.Alltrailers.append(singleTrailer!)
                // print( "cunt of allT  \(m.Alltrailers.count)");
            }
            // a MovieEntity can have more than one Reviews
            for item in aMovie.hasReviewsLink!
            {
                let aReviewEntity = item as! ReviewLinksEntity
                let singleReview = aReviewEntity.review
                //print(singleReview!)
                m.AllReviews.append(singleReview!)
                // print("cunt of allT  \(m.Alltrailers.count)")
            }
        }
        return m;
    }

    func convNSMOToArrOfMovies(NSMArOfMovie: [NSManagedObject]) -> [Movie] {
        var movies =  [Movie]()
        
        for ele in NSMArOfMovie {
            let m : Movie = Movie(id: "",title: "",release_date: "",vote_average: "",overview: "",poster_path: "");
            
            m.id = (ele.value(forKey: "id") as! String)
            m.poster_path = (ele.value(forKey: "posterPath") as! String)
            m.overview = (ele.value(forKey: "overview") as! String)
            m.vote_average = (ele.value(forKey: "voteAvg") as! String)
            m.release_date = (ele.value(forKey: "releaseData") as! String)
            m.title = (ele.value(forKey: "title") as! String)
            
            // single MovieEntity
            let aMovie = ele as! MovieEntity
            // MovieEntity can have more than one Trailer
            for item in aMovie.hasTrilersLink!
            {
                let aTrailerEntity = item as! TrailerLinksEntity
                let singleTrailer = aTrailerEntity.trailer
                // print(singleTrailer!)
                m.Alltrailers.append(singleTrailer!)
                // print( "cunt of allT  \(m.Alltrailers.count)");
            }
            // a MovieEntity can have more than one Reviews
            for item in aMovie.hasReviewsLink!
            {
                let aReviewEntity = item as! ReviewLinksEntity
                let singleReview = aReviewEntity.review
                //print(singleReview!)
                m.AllReviews.append(singleReview!)
                // print("cunt of allT  \(m.Alltrailers.count)")
            }
            // print(m.id!)
            
            movies.append(m)
            // print(index, ":", element)
        }
        //print("count is >> \(movies.count)");
        
        return movies
    }
    
    func convNSMOToArrOfMoviesTopRated(NSMArOfMovie: [NSManagedObject]) -> [Movie] {
        var movies =  [Movie]()
        
        for ele in NSMArOfMovie {
            let m : Movie = Movie(id: "",title: "",release_date: "",vote_average: "",overview: "",poster_path: "");
            
            m.id = (ele.value(forKey: "id") as! String)
            m.poster_path = (ele.value(forKey: "posterPath") as! String)
            m.overview = (ele.value(forKey: "overview") as! String)
            m.vote_average = (ele.value(forKey: "voteAvg") as! String)
            m.release_date = (ele.value(forKey: "releaseData") as! String)
            m.title = (ele.value(forKey: "title") as! String)
            
            // single MovieEntity
            let aMovie = ele as! MovieEntity1
            // MovieEntity can have more than one Trailer
            for item in aMovie.hasTrilersLink!
            {
                let aTrailerEntity = item as! TrailerLinksEntity
                let singleTrailer = aTrailerEntity.trailer
                // print(singleTrailer!)
                m.Alltrailers.append(singleTrailer!)
                // print( "cunt of allT  \(m.Alltrailers.count)");
            }
            // a MovieEntity can have more than one Reviews
            for item in aMovie.hasReviewsLink!
            {
                let aReviewEntity = item as! ReviewLinksEntity
                let singleReview = aReviewEntity.review
                //print(singleReview!)
                m.AllReviews.append(singleReview!)
                // print("cunt of allT  \(m.Alltrailers.count)")
            }
            // print(m.id!)
            
            movies.append(m)
            // print(index, ":", element)
        }
        //print("count is >> \(movies.count)");
        
        return movies
    }
    
    // MARK: - For TestOnly
    
    func printAllMovies(ar : [Movie]) {
        for (i, m) in ar.enumerated() {
            //for m in ar {
            print("\(i) --------------------------------")
            print(m.id)
            print(m.overview)
            print(m.poster_path)
            print(m.vote_average)
            print(m.title)
            print(m.release_date)
            for l in m.Alltrailers {
                print(l)
            }
            for l in m.AllReviews {
                print(l)
            }
        }
    }
    
    // MARK: - >>MostViewMovies<<   Movies, links Entities Methods
    
    // save all response from api to core data
    func saveAllMovies(moviesList : [Movie] ) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        /*create MovieEntity object*/
       for aMovie in moviesList
       {
            let movieEntity = MovieEntity(context: manageContext)

            movieEntity.id = aMovie.id;
            movieEntity.title = aMovie.title
            movieEntity.releaseData = aMovie.release_date
            movieEntity.voteAvg = aMovie.vote_average
            movieEntity.overview = aMovie.overview
            movieEntity.posterPath = aMovie.poster_path
            movieEntity.allTrailerLink = aMovie.trailers
            movieEntity.allReviewLink = aMovie.reviewLink
        
            for trailer in aMovie.Alltrailers {
                let aTrailerLinkEntity = TrailerLinksEntity(context: manageContext)
                aTrailerLinkEntity.trailer = trailer
                movieEntity.addToHasTrilersLink(aTrailerLinkEntity)
            }
            for review in aMovie.AllReviews {
                let aReviewLinksEntity = ReviewLinksEntity(context: manageContext)
                aReviewLinksEntity.review = review
                movieEntity.addToHasReviewsLink(aReviewLinksEntity)
            }
            appDelegate.saveContext()
        }
    }
    
    
    
    func getAllMovies() -> ([NSManagedObject]) {
      //  var movie = [Movie]()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manageContext = appDelegate.persistentContainer.viewContext
        /*fetch data from core data to get value*/
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        do{
            moviesNSObjectList = try manageContext!.fetch(request) as! [NSManagedObject]

        }catch let error{
            print(error)
        }

        return moviesNSObjectList
    }
    
    func getAllMoviesTopRated() -> ([NSManagedObject]) {
        //  var movie = [Movie]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manageContext = appDelegate.persistentContainer.viewContext
        /*fetch data from core data to get value*/
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity1")
        do{
            moviesNSObjectList = try manageContext!.fetch(request) as! [NSManagedObject]
            
        }catch let error{
            print(error)
        }
        
        return moviesNSObjectList
    }
    
    // delete all movies
    func deletAllMovie() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manageContext = appDelegate.persistentContainer.viewContext
        /*fetch data from core data to get value*/
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        do{
            moviesNSObjectList = try manageContext!.fetch(request) as! [NSManagedObject]
        }catch let error{
            print(error)
        }
        for m in moviesNSObjectList {
            manageContext!.delete(m)
            do{
                try manageContext!.save()
            }catch let error{
                print(error)
            }
        }
    }
    
    // to get movie by movie from core data an store it in arrayOfFavouitue movie
    // then send it to TableViewFavouitue movies
    func getMovieById(movieID : (String)) -> [NSManagedObject] {
        var movieObj : [NSManagedObject] = [NSManagedObject]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        /*fetch data from core data to get value*/
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        let predicate = NSPredicate(format: "id == %@", movieID)
        request.predicate = predicate
        
        do{
            movieObj = try manageContext.fetch(request) as! [NSManagedObject]
        }catch let error{
            print(error)
        }
        return movieObj
    }
    
    
    // MARK: - >>TopRatedMovies<<   Movies, links Entities Methods
    // save all response from api to core data
    func saveAllMovies(moviesListTopRated : [Movie] ) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        /*create MovieEntity object*/
        for aMovie in moviesListTopRated
        {
            let movieEntity = MovieEntity1(context: manageContext)
            
            movieEntity.id = aMovie.id;
            movieEntity.title = aMovie.title
            movieEntity.releaseData = aMovie.release_date
            movieEntity.voteAvg = aMovie.vote_average
            movieEntity.overview = aMovie.overview
            movieEntity.posterPath = aMovie.poster_path
            movieEntity.allTrailerLink = aMovie.trailers
            movieEntity.allReviewLink = aMovie.reviewLink
            
            for trailer in aMovie.Alltrailers {
                let aTrailerLinkEntity = TrailerLinksEntity1(context: manageContext)
                aTrailerLinkEntity.trailer = trailer
                movieEntity.addToHasTrilersLink(aTrailerLinkEntity)
            }
            for review in aMovie.AllReviews {
                let aReviewLinksEntity = ReviewLinksEntity1(context: manageContext)
                aReviewLinksEntity.review = review
                movieEntity.addToHasReviewsLink(aReviewLinksEntity)
            }
            appDelegate.saveContext()
        }
    }
    // to get movie by movie from core data an store it in arrayOfFavouitue movie
    // then send it to TableViewFavouitue movies
    func getMovie1ById(movieID : (String)) -> [NSManagedObject] {
        var movieObj : [NSManagedObject] = [NSManagedObject]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        /*fetch data from core data to get value*/
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity1")
        let predicate = NSPredicate(format: "id == %@", movieID)
        request.predicate = predicate
        
        do{
            movieObj = try manageContext.fetch(request) as! [NSManagedObject]
        }catch let error{
            print(error)
        }
        return movieObj
    }
    
    // delete all movies
    func deletAllMovie1() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manageContext = appDelegate.persistentContainer.viewContext
        /*fetch data from core data to get value*/
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity1")
        do{
            moviesNSObjectList = try manageContext!.fetch(request) as! [NSManagedObject]
        }catch let error{
            print(error)
        }
        for m in moviesNSObjectList {
            manageContext!.delete(m)
            do{
                try manageContext!.save()
            }catch let error{
                print(error)
            }
        }
    }
    
    // MARK: - Favoutirte Movie Methods
    /*
     * see if that id in Favs or not to update imageview 
     */
    func getFavMovie(movieID : (String)) -> [NSManagedObject]{
        var movieObj : [NSManagedObject] = [NSManagedObject]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        /*fetch data from core data to get value*/
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteMovie")
        let predicate = NSPredicate(format: "movieID == %@", movieID)
        request.predicate = predicate
        do{
            movieObj = try manageContext.fetch(request) as! [NSManagedObject]
        }catch let error{
            print(error)
        }
        return movieObj
    }
    
    
    func saveFavMovieId(movieID : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
         manageContext = appDelegate.persistentContainer.viewContext
        let favMovie = FavouriteMovie(context: manageContext!)
        favMovie.movieID = movieID
        appDelegate.saveContext()
    }
    
    func deleteFavMovie(movieID : String) {
        var movieObj : [NSManagedObject] = [NSManagedObject]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
         manageContext = appDelegate.persistentContainer.viewContext
        /*fetch data from core data to get value*/
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteMovie")
        let predicate = NSPredicate(format: "movieID == %@", movieID)
        request.predicate = predicate
        do{
            movieObj = try manageContext!.fetch(request) as! [NSManagedObject]
        }catch let error{
            print(error)
        }
        if (!movieObj.isEmpty) {
            manageContext!.delete(movieObj[0])
        }
        do{
            try manageContext!.save()
        }catch let error{
            print(error)
        }
    }
    
    func getAllFavMovie() -> ([NSManagedObject]) {
        var movieObj : [NSManagedObject] = [NSManagedObject]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manageContext = appDelegate.persistentContainer.viewContext
        /*fetch data from core data to get value*/
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteMovie")
        do{
            movieObj = try manageContext!.fetch(request) as! [NSManagedObject]
        }catch let error{
            print(error)
        }
        return movieObj
    }
    
    // to return array of fav movies
    func getArOfFavMovies(favMoviesNSMOAr : [NSManagedObject]) -> [Movie] {
        var favMovies = [Movie]()
        //let nsFavMovies = getAllFavMovie()
        var singleMovie = Movie(id: "",title: "",release_date: "",vote_average: "",overview: "",poster_path: "");
        
        for m in favMoviesNSMOAr {
            let mId =  m.value(forKey: "movieID")
            var mMovieNSArrObject =  getMovieById(movieID: mId as! (String))
            
            if (mMovieNSArrObject.isEmpty) { // means no most viewed
                  mMovieNSArrObject =  getMovie1ById(movieID: mId as! (String))
                if (mMovieNSArrObject.isEmpty) { // mean alerdy removed
                    print("already removed")
                    
//                    deleteFavMovie(movieID: mMovieNSArrObject[0].value(forKey: "movieID") as! String)
                } else {
                    singleMovie = convNSMOToArrOfMoviesToMovie1(NSMArOfMovie: mMovieNSArrObject)
                    favMovies.append(singleMovie)
                }
            } else { // most view
                singleMovie = convNSMOToArrOfMoviesToMovie(NSMArOfMovie: mMovieNSArrObject)
                favMovies.append(singleMovie)
            }
            
        }
        return favMovies
    }
    
    
}
