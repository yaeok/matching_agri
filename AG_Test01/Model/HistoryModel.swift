//
//  HistoryModel.swift
//  AG_Test01
//
//  Created by Kohei Yaeo on 2020/08/09.
//  Copyright © 2020 Kohei Yaeo. All rights reserved.
//

class HistoryModel {
    
    var Title: String?
    var Date: String?
    var Address: String?
    
    init(Title:String?, Date:String?, Address:String?) {
        self.Title = Title;
        self.Date = Date;
        self.Address = Address;
    }
}
