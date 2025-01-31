//
//  ServiceProtocol.swift
//  Kumbaram
//
//  Created by Ozcan Akkoca on 6.01.2024.
//

import Combine
import Foundation
import Alamofire
 
public protocol ServiceProtocol {
    func fetchData<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void)
}

