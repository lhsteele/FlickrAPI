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
    
    override func viewDidLoad() {
    super.viewDidLoad()
    searchFlickrBy("dogs")
        
    }
    
    func searchFlickrBy(_ searchString: String) {
        
    
        let manager = AFHTTPSessionManager()
        
        let searchParameters:[String: Any] = ["method": "flickr.photos.search",
                                              "api_key":  "9ab3bfcbb45d33d191797f08257e6651",
                                              "format": "json",
                                              "nojsoncallback": 1,
                                              "text": searchString,
                                              "extras": "url_m",
                                              "per_page": 5]
        manager.get("https://api.flickr.com/services/rest/",
                    parameters: searchParameters,
                    progress: nil,
                    success: { (operation: URLSessionDataTask, responseObject: Any?) in
                        if let responseObject = responseObject {
                            print("Response: " + (responseObject as AnyObject).description)
                                if let photos = (responseObject as AnyObject)["photos"] as? [String: AnyObject] {
                                if let photoArray = photos["photo"] as? [[String: AnyObject]] {
                                    
                                    let imageWidth = self.view.frame.width
                                    
                                    self.scrollView.contentSize = CGSize(width: imageWidth, height: imageWidth * CGFloat(photoArray.count))
                                
                                    for (i, photoDictionary) in photoArray.enumerated() {
                                        if let imageURLString = photoDictionary["url_m"] as? String {
                                            //let imageData = NSData(contentsOf: URL(string: imageURLString)!)
                                            //if let imageDataUnwrapped = imageData {
                                                let imageView = UIImageView(frame: CGRect(x: 0, y:imageWidth * CGFloat(i), width: imageWidth, height: imageWidth))
                                                if let url = URL(string: imageURLString) {
                                                    imageView.setImageWith(url)
                                                    self.scrollView.addSubview(imageView)
                                                
                                                    
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.delegate = self
        for subview in self.scrollView.subviews {
            subview.removeFromSuperview()
            
        }
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            searchFlickrBy(searchText)
        }
    }
}
    



