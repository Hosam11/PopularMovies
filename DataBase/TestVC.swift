//
//  TestVC.swift
//  MovieProject
//
//  Created by MacOSSierra on 3/11/20.
//  Copyright © 2020 HOS. All rights reserved.
//

import UIKit
import CoreData


class TestVC: UIViewController {
    
    var coreData =  CoreDataOperation()
    
    var movieList : [NSManagedObject] = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
     // MARK: - Operation on Enties Movie and it's links
    @IBAction func printMovies(_ sender: Any) {
        var singleMoviesingleMovie =  coreData.getMovieById(movieID: "123")
        let m = singleMoviesingleMovie[0].value(forKey: "id") as! String
        print(m)
    }
    
    @IBAction func saveMovie(_ sender: Any) {
        
      //  let aMovie = Movie()
//        aMovie.id = "123"
//        aMovie.title = "egel eye"
//        aMovie.release_data = "2017"
//        aMovie.vote_average = "5.7"
//        aMovie.overview = "greate work"
//        aMovie.poster_path = "asdasda"
//        aMovie.trailers = " sass"
//        aMovie.reviewsLink = " sadsd"
//
//        let trailersArrays = ["trailer1","trailer2"]
//        let reviewArrays = ["review1", "review2"]
//
//        for trailer in trailersArrays {
//            aMovie.Alltrailers.append(trailer)
//        }
//        for review in reviewArrays{
//            aMovie.AllReviews.append(review)
//        }
//
//        coreData.saveAllMovies(moviesList: [aMovie])
        
    }
    @IBAction func getAll(_ sender: Any) {
        movieList = coreData.getAllMovies()
        for m in movieList {
            let s =  m.value(forKey: "id") as! String
            print(s)
        }
    }
    
    @IBAction func deletAll(_ sender: Any) {
        coreData.deletAllMovie()
        print("delet all done")
    }
    
     // MARK: - Operation on Favourite Movies
    
    @IBAction func saveFavMovie(_ sender: Any) {
        coreData.saveFavMovieId(movieID: "123")
        print("saved")
    }
    
    @IBAction func getFavMovie(_ sender: Any) {
        var m = coreData.getMovieById(movieID: "123")
        print("count is >> \(m.count)")
        let s =  m[0].value(forKey: "title") as! String
        print("title is >> " + s)
        let notEist = coreData.getMovieById(movieID: "11")
        if notEist.isEmpty {
            print("empty")
        }
    }
    
    @IBAction func deleteFavMovie(_ sender: Any) {
        coreData.deleteFavMovie(movieID: "123")
        print("deleted")
    }
    
    @IBAction func getAllFavMovie(_ sender: Any) {
        movieList = coreData.getAllFavMovie()
        for m in movieList {
            let s =  m.value(forKey: "movieID") as! String
            print(s)
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
