//
//  Constants.swift
//  EffectiveMobile
//
//  Created by Alexandr on 06.12.2022.
//

import Foundation

enum Constans {
    enum API {
        static let sessionConfiguration: URLSessionConfiguration = {
            let sessionConfiguration = URLSessionConfiguration.default
            sessionConfiguration.waitsForConnectivity = true
            return sessionConfiguration
        }()
        
        static let devHost = "run.mocky.io"
        static let devApiVersion = "v3"
    }
}
