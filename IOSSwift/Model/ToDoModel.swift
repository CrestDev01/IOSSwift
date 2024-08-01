//
//  ToDoModel.swift
//  IOSSwift
//
//  Created by CrestAdmin on 31/07/24.
//

import Foundation



struct ToDoModel : Codable {
    let todoId : Int?
    let userId : Int?
    let categoryId : Int?
    let categoryName : String?
    let title : String?
    let description : String?
    
    
    init(todoId: Int?, userId: Int?, categoryId: Int?, categoryName : String?, title: String?,description: String?) {
        self.todoId = todoId
        self.userId = userId
        self.categoryId = categoryId
        self.categoryName  = categoryName
        self.title = title
        self.description = description
    }
    
    enum CodingKeys: String, CodingKey {

        case todoId = "todoId"
        case userId = "UserId"
        case categoryId = "categoryId"
        case categoryName = "categoryName"
        case description = "description"
        case title = "title"
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        todoId = try values.decodeIfPresent(Int.self, forKey: .todoId)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        
    }

}
