//
//  DetailsViewController.swift
//  GIFSearcher
//
//  Created by Vladyslav Gusakov on 5/20/16.
//  Copyright © 2016 Vladyslav Gusakov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var gif: Gif!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    @IBAction func share(sender: AnyObject) {
        
        let vc = UIActivityViewController(activityItems: [self.imageView.image!, NSURL(string: gif.url!)!], applicationActivities: nil)
        
        //vc.excludedActivityTypes = [UIActivityTypeMail]
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Details"
        self.infoView.layer.cornerRadius = 5;
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        idLabel.text = gif.id!
        urlLabel.text = gif.url!
    }
    
    override func viewDidAppear(animated: Bool) {
        print(gif.downsizedUrl!)
        
        imageView.kf_setImageWithURL(NSURL(string: gif.downsizedUrl!)!)

    }

}
