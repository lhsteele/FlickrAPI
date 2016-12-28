//
//  ViewController.swift
//  Photo Search Example
//
//  Created by Lisa Steele on 12/20/16.
//  Copyright © 2016 Lisa Steele. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        for subview in self.scrollView.subviews {
            subview.removeFromSuperview()
            
        }
        searchBar.resignFirstResponder()
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let manager = AFHTTPSessionManager()
        
        let searchParameters:[String: Any] = ["method": "flickr.photos.search",
                                              "api_key":  "9ab3bfcbb45d33d191797f08257e6651",
                                              "format": "json",
                                              "nojsoncallback": 1,
                                              "text": "dogs",
                                              "extras": "url_m",
                                              "per_page": 5]
        manager.get("https://api.flickr.com/services/rest/",
                    parameters: searchParameters,
                    progress: nil,
                    success: { (operation: URLSessionDataTask, responseObject: Any?) in
                        if let responseObject = responseObject as? [String: AnyObject] {
                            
                            
                              if let photos = responseObject["photos"] as? [String: AnyObject] {
                                if let photoArray = photos["photo"] as? [[String: AnyObject]] {
                                    
                                    self.scrollView.contentSize = CGSize(width: 320, height: 320 * CGFloat(photoArray.count))
                                
                                    for (i, photoDictionary) in photoArray.enumerated() {
                                        if let imageURLString = photoDictionary["url_m"] as? String {
                                            let imageData = NSData(contentsOf: URL(string: imageURLString)!)
                                            if let imageDataUnwrapped = imageData {
                                                let imageView = UIImageView(frame: CGRect(x: 0, y:320 * CGFloat(i), width: 320, height: 320))
                                                if let url = URL(string: imageURLString) {
                                                    imageView.setImageWith(url)
                                                    self.scrollView.addSubview(imageView)
                                                
                                                    
                                                }
                                            
                                            }
                                        }
                                    }

                                }
                       
                            }
 
 
                        
                        }
                        
                        
        }) { (operation: URLSessionDataTask?, error: Error) in
            print ("Error: " + error.localizedDescription)
        
        }
        
        
        
    }
    
}


