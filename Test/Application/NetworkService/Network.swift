//
//  Network.swift
//  Test
//
//  Created by Гурген on 16.01.2021.
//

import Foundation
import UIKit

 class Network {
    static func fetchData(_ closure: @escaping (Screen?) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/avito-tech/internship/main/result.json") else {return}
        let reques = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: reques) { (data, response, error) in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            if let screen = Network.parseJSON(withData: data) {
                closure(screen)
            }
        }
        task.resume()
    }
    
    static func parseJSON(withData: Data) -> Screen? {
        let decoder = JSONDecoder()
        do {
            let resultData = try decoder.decode(Welcome.self, from: withData)
            guard let screen = Screen(screenData: resultData) else {
                return nil
            }
            return screen
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
