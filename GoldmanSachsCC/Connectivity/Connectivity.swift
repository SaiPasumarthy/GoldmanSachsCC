//
//  Connectivity.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import Foundation
import Alamofire

/**
    This class represents the connectivity
    Which confirms the whether connection is alive or not
*/
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
