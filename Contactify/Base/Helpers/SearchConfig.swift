//
//  SearchConfig.swift
//  Contactify
//
//  Created by Doni on 6/12/23.
//

import Foundation

struct SearchConfig: Equatable {
    
    enum Filter {
        case all, fave
    }
    
    var query: String = ""
    var filter: Filter = .all
}

enum Sort {
    case asc, desc
}
