//
//  ViewController.swift
//  Photo Search Example
//
//  Created by Lisa Steele on 12/20/16.
//  Copyright © 2016 Lisa Steele. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
   
//Don't forget to connect outlets to Main Storyboard. (drag into View Controller swift instead of typing to ensure connection is made)
    
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
                        //if let responseObject = responseObject as? [String: AnyObject] {
                            
                            
                           //print ("Reponse: " + (responseObject as AnyObject).description)
                            
                            
                            let jsondata = JSON(responseObject)
                            
                            
                        if let flickrImages = jsondata["photos"]["photo"].array {
                            
     // AnyObject doesn't give any information that this will be a list
     // enumerated gives us tuples. the i refers to the index, and the item after is what is in the array.
    // line 51 converts string to a URL object
    // unwrapping happens over two lines (51 and 52) because it is safer
    // NSData and Data are the same object. Only NSData has the contentsOf library, and UIImage only accepts Data object
    // x axis 0 means images are lined up on the left hand side. y axis needs to equal the indexed position of the image times the height. This way it will show one above another, not stacked up images. The reason this is only defined once on line 56 is because it is within the for loop and it knows to iterate through the list of images and their indexes.
    // any time we want to display an image, need to use this: UIImageView(image: UIImage(data: imageDataUnwrapped as Data)) 
                            // UIImage will be obtained either with binary data as here, or it can be an image in the project, or directly through a url.
                            //** don't need to write file extension names
    //on line 60, where we define the image position on the screen (x y axis), this is listed as x: 0 because we want it to line up on the left hand side. If we want it centered, we can use Auto Layout, but this will need to be defined programmatically, because this imageView doesn't even exist on the Main Storyboard. 
                        
                            
                            for (i, image) in flickrImages.enumerated() {
                                if let imageURLString = image["url_m"].string {
                                    let imageData = NSData(contentsOf: URL(string: imageURLString)!)
                                    if let imageDataUnwrapped = imageData {
                                        let imageView = UIImageView(image: UIImage(data: imageDataUnwrapped as Data))
                                        imageView.frame = CGRect(x: 0, y: 320 * CGFloat(i), width: 320, height: 320)
                                        self.scrollView.addSubview(imageView)
                                    }

                                }
                                
                            }
                            
                            self.scrollView.contentSize = CGSize(width: 320, height: CGFloat(320 * flickrImages.count))
                            
   // CGFloat is basically a double, but takes up less memory. All(?) libraries require CG (Core Graphics) objects. Need to cast as a CGFloat because the CGSize is expecting two CG objects. The width is an integer, which internally, will be recast as CG. However, the height is derived by multiplying an integer with another integer, and the computer doesn't know to recast. (?) so need to cast as a CG
                            
                                /*var imageArray: [JSON] = [flickrImages as! JSON]
                                
                               
                                if let singleImage = flickrImages["url_m"].string {
                                    print(singleImage)
                                }
                                
                             
                                for singleImage in flickrImages as? [String: Any?] {
                                    if let image = singleImage["url_m"] as? String {
                                        print(image)
                                    }
                                }
                                
                                if let imageURL = flickrImages["url_m"] as? [String: Any] {
                                    
                                }
                        
                            //print(imageArray)
                            }
                            */
                        
                            /*
                             if let photos = responseObject["photos"] as? [String: AnyObject] {
                                if let photoArray = photos["photo"] as? [[String: AnyObject]] {
                                    
                                    self.scrollView.contentSize = CGSize(width: 320, height: 320 * CGFloat(photoArray.count))
                                
                                    for (i, photoDictionary) in photoArray.enumerated() {
                                        if let imageURLString = photoDictionary["url_m"] as? String {
                                            let imageData = NSData(contentsOf: URL(string: imageURLString)!)
                                            if let imageDataUnwrapped = imageData {
                                                let imageView = UIImageView(image: UIImage(data: imageDataUnwrapped as Data))
                                                imageView.frame = CGRect(x: 0, y: 320 * CGFloat(i), width: 320, height: 320)
                                                self.scrollView.addSubview(imageView)
                                            }
                                        }
                                    }

                                }
                       
                            }
 
 */
                        
                        }
 
 
        }) { (operation: URLSessionDataTask?, error: Error) in
            print ("Error: " + error.localizedDescription)
        
        }
                        
                   
        
}
}


// unexpectedly found nil is usually tied to an optional issue.


      /*
        if let photos = responseObject["photos"] as? [String: AnyObject] {
        if let photoArray = photos["photo"] as? [[String: AnyObject]] {
            self.scrollView.contentSize = CGSize(width: 320, height: 320 * CGFloat(photoArray.count))
            for (i, photoDictionary) in photoArray.enumerate() {
                if let imageURLString = photoDicitonary["url_m"] as? String: {
                    let imageData = NSData(contentsOf: URL(string: imageURLString)!)
                    if let imageDataUnwrapped = imageData {
                        let imageView = UIIMageView(image: UIImage(data: imageDataUnwrapped as Data))
                        imageView.frame = CGRect(x: 0, y: 320 * CGFloat(i), width: 320, height: 320)
                        self.scrollView.addSubview(imageView)
                    }
                }
            }
            }
            }
        }
    }
 
        
    
        // Do any additional setup after loading the view, typically from a nib.
    

    /*override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 */*/
