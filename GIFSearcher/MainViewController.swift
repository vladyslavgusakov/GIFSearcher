//
//  ViewController.swift
//  GIFSearcher
//
//  Created by Vladyslav Gusakov on 5/19/16.
//  Copyright © 2016 Vladyslav Gusakov. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout, GIFDelegate {

    var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var selectedGif: Gif!
    var client: GiphyClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.searchBar = UISearchBar()
        
        self.navigationItem.titleView = self.searchBar
        
        self.searchBar.showsCancelButton = true
        self.searchBar.delegate = self
        
        setupCollectionView()
        
        client = GiphyClient()
        client.delegate = self
        client.getTrending()
        
    }

    func dissmissKeyboard() {
        self.searchBar.text = ""
        self.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        let query = searchBar.text!

        print("searching... 1/2 ", query)
        self.titleLabel.text = query
        self.dissmissKeyboard()
        
        client.searchFor(query)
    }

    
    func reloadGifs() {
        self.collectionView?.reloadData()
        print(self.client.gifs.count)
        self.collectionView.setContentOffset(CGPointZero, animated: false)
    }
    
    func setupCollectionView(){
        
        // Create a waterfall layout
        let layout = CHTCollectionViewWaterfallLayout()
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            // iPad
            layout.columnCount = 3
        } else {
            // iPhone/iPod
            layout.columnCount = 2
        }
        
        // Change individual layout attributes for the spacing between cells
        layout.minimumColumnSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        
        // Collection view attributes
        self.collectionView!.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        self.collectionView!.alwaysBounceVertical = true
        
        // Add the waterfall layout to your collection view
        self.collectionView!.collectionViewLayout = layout
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.client.gifs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! GIFCell
        let currGif = self.client.gifs[indexPath.row]
//        cell.imageView.kf_setImageWithURL(NSURL(string: currGif.downsizedUrl!)!)
        
        cell.imageView.kf_setImageWithURL(NSURL(string: currGif.downsizedUrl!)!, placeholderImage: UIImage(named: "load.png"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)

        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedGif = self.client.gifs[indexPath.row]
        
        self.performSegueWithIdentifier("showImage", sender: nil)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let currGif = self.client.gifs[indexPath.row]
        
        let newWidth = CGFloat(self.view.frame.size.width)/2
        let scale = CGFloat(currGif.width)/newWidth
        let newHeight = CGFloat(currGif.height)/scale
        
        return CGSizeMake(newWidth, newHeight);
    }
    
    func collectionView (collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        (cell as! GIFCell).imageView.image = nil

//        if (collectionView.indexPathsForVisibleItems().indexOf(indexPath) == NSNotFound)
//        {
//            // This indeed is an indexPath no longer visible
//            // Do something to this non-visible cell...
//        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage" {
            let detailVC = segue.destinationViewController as! DetailsViewController
            detailVC.gif = selectedGif
//            print(selectedGif.originalUrl!)
        }
    }

    
}

