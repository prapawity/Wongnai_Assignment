//
//  APIController.swift
//  Wongnai Assignment (Intern)
//
//  Created by Prapawit Patthasirivichot on 6/1/2563 BE.
//  Copyright © 2563 Prapawit Patthasirivichot. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class APIController{
    // create call api function
    public static func callApi(completion:@escaping ([ImageCell]) -> Void){
        let array:[String] = ["1","2","3","4"] // list page number
        let host = "https://api.500px.com/v1/photos?feature=popular&page="+(array.randomElement() ?? "1") // set host url
        var dataArray: [ImageCell] = []
        AF.request(host).responseJSON{ // request data to api
            (response) in
            // get respose
            switch response.result {
                case .success: //if success
                    if let json = response.data {
                        do{
                            let data = try JSON(data: json)
                            let str = data["photos"] // str wil be (index,dictionary)
                            for item in str {
                                let imgCell = ImageCell(name: item.1["name"].string?.replacingOccurrences(of: " ", with: "") ?? "No Name", img: item.1["image_url"][0].string ?? "https://i.imgur.com/FPC6uwX.png", desc: item.1["description"].string?.replacingOccurrences(of: " ", with: "") ?? "description", vote: item.1["votes_count"].int ?? 0)
                                dataArray.append(imgCell)
                            }
                            completion(dataArray)
                        }
                        catch{
                            print("JSON Error")
                        }
                    }
                case .failure(let error): // if error
                    print(error)
            }
        }

    }
        
}

