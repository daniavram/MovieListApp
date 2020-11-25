//
//  Array+ElementAt.swift
//  MovieListApp
//
//  Created by daniel.avram on 25/11/2020.
//

import Foundation

extension Array {

    func element(at index: Int) -> Element? {
        if 0 ..< count ~= index {
            return self[index]
        } else {
            return nil
        }
    }

}
