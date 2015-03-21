//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Daniel Frank on 3/20/15.
//  Copyright (c) 2015 Daniel Frank. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String?)
    {
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
}
