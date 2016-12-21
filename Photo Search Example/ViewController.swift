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
                        if let responseObject = responseObject {
                            print ("Reponse: " + (responseObject as AnyObject).description)
                            
                            let jsondata = JSON(responseObject)
                            
                            if let flickrImageURL = jsondata["photos"]["photo"][0]["url_m"] as? AnyObject{
                                print(flickrImageURL)
                            }
                            

                        }
        }) { (operation: URLSessionDataTask?, error: Error) in
            print ("Error: " + error.localizedDescription)
        
        }
                        
                   
        
}
}





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
