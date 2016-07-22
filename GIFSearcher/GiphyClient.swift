//
//  GiphyClient.swift
//  GIFSearcher
//
//  Created by Vladyslav Gusakov on 5/20/16.
//  Copyright © 2016 Vladyslav Gusakov. All rights reserved.
//

import UIKit
import Alamofire

protocol GIFDelegate {
    func reloadGifs()
}

class GiphyClient {
    
    var gifs = [Gif]()
    var delegate : UIViewController?
    
    func getTrending() {
        makeRequest(kRequestTrending, parameters: [kApi_key: kBetaKey, kLimit : 30])
    }
    
    func searchFor (query: String) {
        
        print("searching... 2/2 ", query)
        let modifiedQuery = query.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        makeRequest(kRequestSearch, parameters: ["q": modifiedQuery, kApi_key: kBetaKey, kLimit : 30])
    }
    
    func makeRequest(type: String, parameters: [String: AnyObject]) {
        
        if let viewController = delegate {
            
            if let mainVC = viewController as? GIFDelegate {
                
                let url = kURL.stringByAppendingString(type)
                print(url)
                
                Alamofire.request(.GET, url, parameters: parameters)
                    .responseSwiftyJSON({ (request, response, json, error) in
                        print(json)
                        self.gifs = Gif.translateFromJSON(json)
                        print(self.gifs.count)

                        mainVC.reloadGifs()
                    })

            }
            
        }
        
    }

    
}
