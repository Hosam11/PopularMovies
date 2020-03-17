//
//  ViewController.swift
//  SwiftProject
//
//  Created by MacOSSierra on 3/6/20.
//  Copyright © 2020 MAhmoud. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
class ViewController: UIViewController {
    @IBOutlet weak var MyimageView: UIImageView!
    
    var movies=[Movie]()
    var i : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("hell")
        Alamofire.request("http://api.themoviedb.org/3/discover/movie?.%20desc&api_key=5dd85a7606bbd9d15e62b9cfb6fe2fa6").responseJSON{ (response) in switch (response.result){
        case .success(let value):
            let Json = JSON(value)
            let data = Json["results"]
            data.array?.forEach({(movie)in
                var movie = Movie(id: movie["id"].stringValue, title: movie["title"].stringValue, release_date: movie["release_date"].stringValue, vote_average: movie["vote_average"].stringValue, overview: movie["overview"].stringValue, poster_path: movie["poster_path"].stringValue)
                
                if movie.title==""
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
//                            print(movie.title)
//                            print(trailer)
//                            print("************")
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
//                            print(movie.title)
//                            print(review)
//                            print("*******************************")
                            movie.AllReviews.append(review)
                        }
                        
                    })
                    self.i=self.i+1
                    if self.i==self.movies.count
                    {
                        //enter your code here
                        self.hello()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                    }
                })
                
            }
            
            //put here your code
          
            
        case .failure(let error):
            print(error.localizedDescription)
            
            }
            print("hello")
        }
        
        print("hello")
    }
    
    
    func hello ()
    {
        print(movies[0].title)
        print(movies[0].Alltrailers[0])
       // print(movies[1].AllReviews[1])
        print(movies[0].poster_path)
        MyimageView.sd_setImage(with: URL(string: movies[0].poster_path), placeholderImage: UIImage(named: "1.png"))
        
        
    }
    
    }



