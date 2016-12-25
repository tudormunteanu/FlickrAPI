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
						
						// Optional unwrapping is correct. 
						// NOTE: We also need to enforce a certain data type to
						// unwrapped result, thus the "as? [String: AnyObject]"
						// The course says:
						/*
						"Just like you did with in Open Weather Map Web Services in 4.2.4, go ahead and use Optional Binding to get a constant based on this Dictionary, of type [String: AnyObject]:"
						*/
						// If you read carefuly, "of type [String: AnyObject]" tells us exactly
						// this. 
						// Without this case when unwrapping, the [] syntax on an Any type
						// doesn't make logical sense.
                        if let responseObject = responseObject as? [String: AnyObject] {
							
                            print("Reponse: " + (responseObject as AnyObject).description)
							
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
