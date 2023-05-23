//
//  ErrorData.swift
//  Findit
//
//  Created by Ivan on 23/05/23.
//

import Foundation

/**
    Represent all humanize error data in Findit application
 */
final class ErrorData: ObservableObject {
    @Published var errorFields: [ErrorField] = []
}
