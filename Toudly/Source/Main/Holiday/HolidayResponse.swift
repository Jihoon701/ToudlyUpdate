//
//  HolidayResponse.swift
//  Toudly
//
//  Created by 김지훈 on 2023/01/12.
//

import Foundation

struct HolidayResponse: Decodable {
    let response: Response
}

struct Header: Decodable {
    let resultCode: ResponseResult
    let resultMsg: String
}

enum ResponseResult: String, Codable  {
    case success = "00"
    case fail
}

struct Response: Decodable {
    let header: Header
    let body: Body
}

struct Body: Decodable {
    let items: Items
    let numOfRows, pageNo, totalCount: Int
}

struct Items: Decodable {
    let item: [Item]
}

struct Item: Decodable {
    let dateKind, dateName, isHoliday: String
    let locdate, seq: Int
}
