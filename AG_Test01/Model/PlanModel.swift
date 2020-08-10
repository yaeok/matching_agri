//
//  PlanModel.swift
//  AG_Test01
//
//  Created by Kohei Yaeo on 2020/08/09.
//  Copyright © 2020 Kohei Yaeo. All rights reserved.
//

class PlanModel {
    
    var Id: String?
    var Title: String?
    var Date: String?
    var Address: String?
    var Money: String?
    var Content: String?
    
    init(Id:String?, Title:String?, Date:String?, Address:String?, Money:String?, Content:String?) {
        self.Id = Id;
        self.Title = Title;
        self.Date = Date;
        self.Address = Address;
        self.Money = Money;
        self.Content = Content;
    }
}
