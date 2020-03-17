//
//  MyCollectionViewController.swift
//  SwiftProject
//
//  Created by MacOSSierra on 3/7/20.
//  Copyright © 2020 MAhmoud. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import DropDown
import Network
import CoreData

private let reuseIdentifier = "mycell"

class MyCollectionViewController: UICollectionViewController {
    var reachable : Reachable!
    var movies=[Movie]()
    var i : Int = 0
    @IBOutlet weak var ToSoryButton: UIBarButtonItem!
    var movieDetails : MovieDetailsVC!
    var coreDate : CoreDataOperation = CoreDataOperation()
    var isMostView : Bool = true
    
    @IBAction func Showmenu(_ sender: UIBarButtonItem) {
        let dropDown = DropDown()
        dropDown.anchorView = ToSoryButton
        dropDown.dataSource = ["Most Viewed", "Top Rated"]
        dropDown.bottomOffset = CGPoint(x:100,y:30)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            switch(index)
            {
            case 0:
                if(self.reachable == Reachable.yes)
                {
            self.getData(url: "http://api.themoviedb.org/3/discover/movie?.%20desc&api_key=5dd85a7606bbd9d15e62b9cfb6fe2fa6")
            self.isMostView = true
                }
                else
                {
                let NSMovieAr : [NSManagedObject] = self.coreDate.getAllMovies()
                self.movies =  self.coreDate.convNSMOToArrOfMovies(NSMArOfMovie: NSMovieAr)
                DispatchQueue.main.async {
                self.collectionView.reloadData()
                                          }
                }
                break
                
            case 1:
                if(self.reachable == Reachable.yes)
                {
                self.getData(url: "http://api.themoviedb.org/3/discover/movie?sort_by=highest-rated.%20desc&api_key=5dd85a7606bbd9d15e62b9cfb6fe2fa6")
                    self.isMostView = false
                }
                else
                {
                    let NSMovieAr : [NSManagedObject] = self.coreDate.getAllMoviesTopRated()
                    self.movies =  self.coreDate.convNSMOToArrOfMoviesTopRated(NSMArOfMovie: NSMovieAr)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                break
                
            default:
                self.getData(url: "http://api.themoviedb.org/3/discover/movie?.%20desc&api_key=5dd85a7606bbd9d15e62b9cfb6fe2fa6")
            }
        }

        
        DispatchQueue.main.async
            {
            dropDown.show()
            }
    }
    
    
    private func doSomething(_ connection: Connection, reachable: Reachable) {
            self.reachable=reachable
            if(reachable == Reachable.yes)
            {
                print("Connected")
                getData(url: "http://api.themoviedb.org/3/discover/movie?.%20desc&api_key=5dd85a7606bbd9d15e62b9cfb6fe2fa6")
            }
            else
            {
                print("Not Connected")
                let NSMovieAr : [NSManagedObject] = coreDate.getAllMovies()
                movies =  coreDate.convNSMOToArrOfMovies(NSMArOfMovie: NSMovieAr)
                DispatchQueue.main.async
                    {
                    self.collectionView.reloadData()
                    }
            }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetails = (self.storyboard?.instantiateViewController(withIdentifier: "movieDetails") as! MovieDetailsVC)
        
        Monitor().startMonitoring { [weak self] connection, reachable in
            guard let strongSelf = self else { return }
            strongSelf.doSomething(connection, reachable: reachable)
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
    
    
    func getData(url : String)
    {
        DispatchQueue.main.async
            {
          self.collectionView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible=true
           }
        
        movies=[Movie]()
            Alamofire.request(url).responseJSON{ (response) in switch (response.result){
        case .success(let value):
            let Json = JSON(value)
            let data = Json["results"]
            data.array?.forEach({(movie)in
                var movie = Movie(id: movie["id"].stringValue, title: movie["title"].stringValue, release_date: movie["release_date"].stringValue, vote_average: movie["vote_average"].stringValue, overview: movie["overview"].stringValue, poster_path: movie["poster_path"].stringValue)
                
                if movie.title==""||movie.poster_path==""||movie.release_date==""
                {
                    
                }
                else
                {
                    
                    self.movies.append(movie)
                }
                
            })
            
            for movie in self.movies{
                Alamofire.request(movie.trailers).responseJSON(completionHandler:{ (response) in switch (response.result){
                case .success(let value):
                    let Json = JSON(value)
                    let data = Json["results"]
                    data.array?.forEach({(trailer)in
                        let trailer = "https://www.youtube.com/watch?v="+trailer["key"].stringValue
                        
                        if trailer==""
                        {
                            
                        }
                        else
                        {
                            movie.Alltrailers.append(trailer)
                        }
                        
                    })
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    }
                })
                
            }
            
            
            for movie in self.movies{
                Alamofire.request(movie.reviewLink).responseJSON(completionHandler:{ (response) in switch (response.result){
                case .success(let value):
                    let Json = JSON(value)
                    let data = Json["results"]
                    data.array?.forEach({(review)in
                        let review = review["content"].stringValue
                        
                        if review==""
                        {
                            
                        }
                        else
                        {
                            movie.AllReviews.append(review)
                        }
                        
                    })
                case .failure(let error):
                    print(error.localizedDescription)
                    
                    }
                })
            }
           
            if (self.isMostView) {
                self.coreDate.deletAllMovie()
                self.coreDate.saveAllMovies(moviesList: self.movies)
            } else {
                self.coreDate.deletAllMovie1()
                self.coreDate.saveAllMovies(moviesListTopRated: self.movies)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible=true
            }
                
            
            case .failure(let error):
            print(error.localizedDescription)
            
            }
          
            }
   
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        var imageView :UIImageView=cell.viewWithTag(1) as! UIImageView
        
    
        imageView.sd_setImage(with: URL(string: movies[indexPath.row].poster_path), placeholderImage: UIImage(named: "h.png"))
        
        
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(movies[indexPath.row].title)
        movieDetails.movieRecived = movies[indexPath.row]
        self.navigationController?.pushViewController(movieDetails, animated: true)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
extension MyCollectionViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfcolumns:CGFloat=2
        let width = collectionView.frame.size.width;
        let xInsets : CGFloat = 10;
        let cellSpacing : CGFloat=5;
        return CGSize(width: (width/numberOfcolumns)-(xInsets+cellSpacing), height:0.75*(collectionView.frame.size.width))
    }
}
