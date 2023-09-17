//
//  ObservableObject.swift
//  Movies
//
//  Created by Softsuave on 16/09/2023.
//

import Foundation


class ObservableObject<T> {
    //MARK: - Variables
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?
    
    //MARK: - Initialisers
    init(_ value: T) {
        self.value = value
    }
    
    //MARK: - Other methods
    func bind(_ listener: @escaping(T) -> Void) {
        listener(value)
        self.listener = listener
    }
}
