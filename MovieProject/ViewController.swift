//
//  ViewController.swift
//  MovieProject
//
//  Created by Mac on 24.07.2017.
//  Copyright © 2017 Varol. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchText: UITextField!
  
    
    var filmAdiArray = [String]()
    var filmYiliArray = [String]()
    var filmPuanArray = [Double]()
    var filmAciklamaArray = [String]()
    var apiUrl : String = ""
    var filmPoster = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getAPI(title: searchText.text!)
        searchText.text = "Batman"
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // her zamanki tableview işlemi. kaç satır olacağını bildiriyoruz.
        return filmAdiArray.count
    }
    
   

    func getAPI(title: String) {
        
        
        if let movie = title.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {

            let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=&language=tr-TR&query=\(movie)&page=1&include_adult=false")
            
            
            
            Alamofire.request(url!, parameters: ["results": "overview"])
            .responseJSON { response in
                if let jsonValue = response.result.value {
                    let json = JSON(jsonValue)
                    
                    self.filmAdiArray.removeAll(keepingCapacity: false)
                    self.filmYiliArray.removeAll(keepingCapacity: false)
                    self.filmPuanArray.removeAll(keepingCapacity: false)
                    self.filmAciklamaArray.removeAll(keepingCapacity: false)
                    self.filmPoster.removeAll(keepingCapacity: false)

                    for i in 0...json.count  {
                        if let title = json["results"][i]["original_title"].string{
                            self.filmAdiArray.append(title)
                        }
                        if let filmyili = json["results"][i]["release_date"].string{
                            self.filmYiliArray.append(filmyili)
                        }
                        if let vote = json["results"][i]["vote_average"].double{
                            self.filmPuanArray.append(vote)
                        }
                        
                        if let aciklama = json["results"][i]["overview"].string{
                            self.filmAciklamaArray.append(aciklama)
                        }
                        
                        if let poster = json["results"][i]["backdrop_path"].string{
                            self.filmPoster.append(poster)
                        }

//
                    }

                }
        }
        self.tableView.reloadData()

        } else {
            let alert = UIAlertController(title: "Error", message: "bi' şeyler yanlış oldu", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion:  nil)

        }
    }

  
    
    
    
    
    
    
    @IBAction func getirButton(_ sender: Any) {

        getAPI(title: searchText.text!)
        
        view.endEditing(true)

    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! filmCell
        cell.filmAdiLbl.text = filmAdiArray[indexPath.row]
        cell.filmYiliLbl.text = "Yapım Yılı: \(filmYiliArray[indexPath.row])"
        cell.filmTuruLbl.text = "Film Puanı: \(filmPuanArray[indexPath.row])"
        cell.aciklamaLbl.text = filmAciklamaArray[indexPath.row]

        let url1 = URL(string:"https://image.tmdb.org/t/p/w780/\(filmPoster[indexPath.row])")
        let data = NSData(contentsOf: url1!)
       
            cell.posterImg.image = UIImage(data:data! as Data)
     

        
        
      

        
        
        return cell
    }
    


}

