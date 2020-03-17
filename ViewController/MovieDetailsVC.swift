//
//  ViewController.swift
//  MovieProject
//
//  Created by MacOSSierra on 3/6/20.
//  Copyright © 2020 HOS. All rights reserved.
//

import UIKit
import YouTubePlayer
import Cosmos

class MovieDetailsVC: UIViewController , UITableViewDelegate, UITableViewDataSource {

    // MARK: - Variables section

    @IBOutlet weak var ivMoviePoster: UIImageView!
    @IBOutlet weak var labelMovieName: UILabel!

    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var reviewTable: UITableView!
    
    @IBOutlet weak var tvStroyline: UITextView!
    
    @IBOutlet weak var heigttConsTV: NSLayoutConstraint!
    
    @IBOutlet weak var heartIV: UIImageView!
    
    @IBOutlet weak var cosmos: CosmosView!

    @IBOutlet weak var yTubeVeiw: YouTubePlayerView!
    @IBOutlet weak var yTubeVeiw2: YouTubePlayerView!
    
    var isFav : Bool = false
    
    var movieReviews : [String] = []
    //var movieTrailers : [String] = []
    var movieRecived : Movie!
    var coreData : CoreDataOperation?
    
    // MARK: - ViewController Section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        // Do not change rating when touched
        // Use if you need just to show the stars without getting user's input
        cosmos.settings.updateOnTouch = false
        cosmos.settings.fillMode = .precise
        
        
        reviewTable.dataSource = self
        reviewTable.delegate = self
        
        coreData = CoreDataOperation()
        

        //   self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + 20.0)
//        yTubeView.supervi
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        heartIV.isUserInteractionEnabled = true
        heartIV.addGestureRecognizer(tapGestureRecognizer)
        
        print("titles is >> " + movieRecived.title)
        
      //  ivMoviePoster.image = UIImage(named: movieRecived.poster_path)
        ivMoviePoster.sd_setImage(with: URL(string: movieRecived.poster_path), placeholderImage: UIImage(named: "h.png"))
        
        labelMovieName.text = movieRecived.title
        labelDate.text = movieRecived.release_date
        tvStroyline.text = movieRecived.overview
        labelRate.text = movieRecived.vote_average
        let x = Double(movieRecived.vote_average)
        cosmos.rating = (x!/2)
        if (!movieRecived.Alltrailers.isEmpty) {
            let link1 =  movieRecived.Alltrailers[0].components(separatedBy: "=")[1]
            yTubeVeiw.loadVideoID(link1);
            print("link1>> \(link1)")
        }
        if (movieRecived.Alltrailers.count > 1 ) {
            var link2 =  movieRecived.Alltrailers[1].components(separatedBy: "=")[1]
            yTubeVeiw2.loadVideoID(link2);
            print("link2>> \(link2)")
        }
        movieReviews = movieRecived.AllReviews
        print("id >> \(movieRecived.id)");
        
        //
        let NSMovieAr =  coreData?.getFavMovie(movieID: movieRecived.id)
        if (NSMovieAr!.isEmpty) {
            print("not fav from willApear")
            heartIV.image = UIImage(named: "emptyHeart.png")
            isFav = false
        } else {
            print("is fav from willApear")
            heartIV.image = UIImage(named: "fillHeart.png")
            isFav = true
        }
        
        reviewTable.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.heigttConsTV?.constant = self.reviewTable.contentSize.height
    }
    
    // MARK: - TableView Section
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension;
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if movieReviews.isEmpty {
            return 1
        } else {
            return movieReviews.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReview", for: indexPath)
        // Configure the cell...
        if (movieReviews.isEmpty) {
            cell.textLabel?.text = "No reviews to show"
              return cell
            
        }else {
            cell.textLabel?.text = movieReviews[indexPath.row]
            // cell.textLabel?.text = "no reviews fir that movie"
        
            //var frame = tableView.frame
            //frame.size.height = tableView.contentSize.height
            //tableView.frame = frame
     
            return cell
        }
    
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
       // let tappedImage = tapGestureRecognizer.view as! UIImageView
        // if not fav then user click will become fav so save in core data
        if (isFav == false) {
            print("was not fav")
            heartIV.image = UIImage(named: "fillHeart.png")
            coreData?.saveFavMovieId(movieID: movieRecived.id)
            isFav = true
        } else {
            print("was  fav")
             heartIV.image = UIImage(named: "emptyHeart.png")
            coreData?.deleteFavMovie(movieID: movieRecived.id)
            isFav = false
        }
    }
    
 
    /*
    func setStarts(rate : String){
        let rateFloat = Double(rate)!
        
        switch rateFloat {
        case 0.0..<2.0:
            print("case 0")
            star1.image = UIImage(named: "halfStar")
        case 2.0..<3.0:
            print("case is 1")
            star1.image = UIImage(named: "fillStar.png")
        case 3.0..<4.0:
            print("case is 2")
            star1.image = UIImage(named: "fillStar.png")
            star2.image = UIImage(named: "halfStar.png")
        case 4.0..<5.0:
            star1.image = UIImage(named: "fillStar.png")
            star2.image = UIImage(named: "fillStar.png")
        case 5.0..<6.0:
            star1.image = UIImage(named: "fillStar.png")
            star2.image = UIImage(named: "fillStar.png")
            star3.image = UIImage(named: "halfStar.png")
        case 6.0..<7.0:
            fillFirst3Stars()
        case 7.0..<8.0:
            fillFirst3Stars()
            star4.image = UIImage(named: "halfStar.png")
        case 8.0..<9.0:
            fillFirst3Stars()
            star4.image = UIImage(named: "fillStar.png")
        case 9.0..<10.0:
            fillFirst3Stars()
            star4.image = UIImage(named: "fillStar.png")
            star5.image = UIImage(named: "halfStar.png")
        default:
            fillFirst3Stars()
            star4.image = UIImage(named: "fillStar.png")
            star5.image = UIImage(named: "fillStar.png")
        }
    }
    func fillFirst3Stars() {
        star1.image = UIImage(named: "fillStar.png")
        star2.image = UIImage(named: "fillStar.png")
        star3.image = UIImage(named: "fillStar.png")
    }
     */
    

}


