//
//  ViewController.swift
//  iOS Lyric Learner
//
//  Created by Mason Nesbitt on 10/23/18.
//  Copyright © 2018 Mason Nesbitt. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var songText: UITextField!
    @IBOutlet weak var lyricText: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func submitTapped(_ sender: Any) {
        guard let artistName = artistText.text, let songTitle = songText.text else { return}
        
        let lyricsAPIBaseURL = "https://api.lyrics.ovh/v1/"
        
        let artistNameURLComponent = artistName.replacingOccurrences(of: " ", with: "+")
        let songTitleURLComponent = songTitle.replacingOccurrences(of: " ", with: "+")
    
        let requestURL = lyricsAPIBaseURL + artistNameURLComponent + "/" + songTitleURLComponent
    
        let request = Alamofire.request(requestURL, method: .get, parameters: nil, encoding: JSONEncoding.default,  headers: nil)
        
        request.responseJSON { response in
            switch response.result {
                case .success(let value):
                    print(value)
                
                let json = JSON(value)
                
                print(json)
                
                self.lyricText.text = json["lyrics"].stringValue
                
                print("Success")
                
                case .failure(let error): self.lyricText.text = "Error"
            }
        }
    }
}
