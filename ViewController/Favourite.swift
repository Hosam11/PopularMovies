//
//  Favourite.swift
//  SwiftProject
//
//  Created by MacOSSierra on 3/13/20.
//  Copyright © 2020 MAhmoud. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class Favourite: UITableViewController {
    
    
    var movies = [Movie]()
    var i : Int = 0
    
    var coreData : CoreDataOperation = CoreDataOperation()
    var movieDetails : MovieDetailsVC!


    override func viewWillAppear(_ animated: Bool) {
        // get all favouite
      //  movies = get all favouite
       //  coreData.deleteFavMovie(movieID: "565588")
         //  print("id>> \(movieList[0].value(forKey: "movieID")!)")
        
        let movieList = coreData.getAllFavMovie()
        print("count movieList is >> \(movieList.count)")
       
        movies = coreData.getArOfFavMovies(favMoviesNSMOAr: movieList)
        print("count movies is >> \(movies.count)")
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favourite"
         movieDetails = (self.storyboard?.instantiateViewController(withIdentifier: "movieDetails") as! MovieDetailsVC)
      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath)
        var mylabel : UILabel=cell.viewWithTag(1) as! UILabel
        mylabel.text=movies[indexPath.row].title
        var imageView :UIImageView=cell.viewWithTag(2) as! UIImageView
        imageView.layer.cornerRadius=imageView.frame.size.width / 2
        imageView.clipsToBounds=true
         imageView.sd_setImage(with: URL(string: movies[indexPath.row].poster_path), placeholderImage: UIImage(named: "h.png"))

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieDetails.movieRecived = movies[indexPath.row]
        self.navigationController?.pushViewController(movieDetails, animated: true)
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            coreData.deleteFavMovie(movieID: movies[indexPath.row].id)
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        }
          
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favourites"
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Helvetica Neue", size: 35.0)
        header.textLabel?.textAlignment = NSTextAlignment.center
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
return 70
    }

}
