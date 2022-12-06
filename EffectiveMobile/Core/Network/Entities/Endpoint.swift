//
//  Endpoint.swift
//  EffectiveMobile
//
//  Created by Alexandr on 06.12.2022.
//

import Foundation
import UIKit

protocol EndpointProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
}
