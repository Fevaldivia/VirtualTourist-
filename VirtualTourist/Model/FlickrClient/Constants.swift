//
//  Constants.swift
//  VirtualTourist
//
//  Created by Felipe Valdivia on 4/23/18.
//  Copyright © 2018 Felipe Valdivia. All rights reserved.
//


struct FlickrClient {
    struct Constants {
        static let APIKey = "c549371f5b51bff698f39763eb6c95f7"
        static let BaseUrl = "https://api.flickr.com/services/rest/"
    }
    
    struct Methods {
        static let SEARCH = "flickr.photos.search"
    }
    
    struct ParameterKeys {
        static let API_KEY = "api_key"
        static let METHOD = "method"
        static let SAFE_SEARCH = "safe_search"
        static let EXTRAS = "extras"
        static let FORMAT = "format"
        static let NO_JSON_CALLBACK = "nojsoncallback"
        static let BBOX = "bbox"
        static let PAGE = "page"
        static let PER_PAGE = "per_page"
        static let SORT = "sort"
    }
    
    struct ParameterValues {
        static let JSON_FORMAT  = "json"
        static let URL_M        = "url_m"
    }
    
    struct BBoxParameters {
        static let BOUNDING_BOX_HALF_WIDTH = 1.0
        static let BOUNDING_BOX_HALF_HEIGHT = 1.0
        static let LAT_MIN = -90.0
        static let LAT_MAX = 90.0
        static let LON_MIN = -180.0
        static let LON_MAX = 180.0
    }
}
