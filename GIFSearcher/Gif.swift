//
//  GIF.swift
//  GIFSearcher
//
//  Created by Vladyslav Gusakov on 5/20/16.
//  Copyright © 2016 Vladyslav Gusakov. All rights reserved.
//

import UIKit
import SwiftyJSON

class Gif {
    
    var downsizedUrl: String?
    var width: Int = 0
    var height: Int = 0
    var id: String?
    var url: String?
    
}

extension Gif {
    class func translateFromJSON(json: JSON?) -> [Gif] {
        
            if let jsonGifs = json!["data"].array {
                
                var gifs = [Gif]()
                for jsonGif in jsonGifs {
                    let gif = Gif()
                    gif.downsizedUrl = jsonGif["images"]["downsized"]["url"].string!
                    gif.width = Int(jsonGif["images"]["original"]["width"].string!)!
                    gif.height = Int(jsonGif["images"]["original"]["height"].string!)!
                    gif.id = jsonGif["id"].string!
                    gif.url = jsonGif["bitly_gif_url"].string!
                    
                    gifs.append(gif)
                }
                return gifs
            } else{
                print(json)
            }
        return [Gif]()
    }
}