//
//  TickerAPIService.swift
//  FakeBithumbAssignment
//
//  Created by chihoooon on 2022/03/05.
//

import Foundation

struct TickerAPIService {
    private let apiService: HttpService
    private let environment: HttpEnvironment

    init(apiService: HttpService, environment: HttpEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func getTickerData(orderCurrency: String) async throws -> AllTickerResponse? {
        let request = TickerEndPoint
            .getTickerData(orderCurrency: orderCurrency)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func getOneTickerData(orderCurrency: String) async throws -> Item? {
        let request = TickerEndPoint
            .getOneTickerData(orderCurrency: orderCurrency)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
