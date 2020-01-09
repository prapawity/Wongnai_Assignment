//
//  ViewController.swift
//  Wongnai Assignment (Intern)
//
//  Created by Prapawit Patthasirivichot on 6/1/2563 BE.
//  Copyright © 2563 Prapawit Patthasirivichot. All rights reserved.
//

// Question during interview

//  optional is something contain data and that will be nil or not nil
//  How different of optional declare when use ? and !
//  let hello : String? = "Hello" define data but not sure about that data can be nil then use ? to them when wants to use need to unwrap and check about that data is nil or not
//  var world : String! = "World" very sure abot that data can't be nil

// how to unwrap optional
// 1. Force, use ! order to unwrap optional
// 2. Check if not nil before Force
// 3. if let, wil get a pyramid of doom
// 4. guard let, it likely an if let but guard will use statement when codeBlock is false

// strong weak unowned, ARC
// strong, save data to memory, strong will not automatically terminate, if wants to terminate needs to delete pointer to that data, or set nil, by default when define data will be strong
// weak, if no one of strong do not reference, they will auto terminate
// unowned, likely weak but can not be nil

import UIKit
enum Section: Int,CaseIterable{
    case data,loadMore
}

class ViewController: UIViewController {
    
    // define value
    private var refresh: Bool = true
    private var dataArray: [ImageCell] = []
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setUp()
    }
    
    // setUp Function
    private func setUp(){
        tableViewSetup()
    }
    
    private func tableViewSetup(){
        self.tableView.dataSource = self // set tableView to connecting to this view (datasource is about data something to use in this tableview)
        self.tableView.delegate = self // et tableView to connecting to this view (delegate is something about event action on cell)
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        self.tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: "loading")
        // register xib to tableView
    }
    
    
    // call api and append data from json to dataArray
    private func setupData(){
        // call api
        APIController.callApi { (callBack) in
            // callback is return data after recive data from api is complete (callback, completion)
            callBack.forEach { (ImageCell) in
                self.dataArray.append(ImageCell)
            }
            // reload data on tableview
            self.tableView.reloadData()
        }

    }

}

extension ViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .data:
            return dataArray.count
        case .loadMore:
            return refresh ? 1 : 0
        }
    }
    
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section)! {
            case .data:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell{
                    cell.setCell(cell: dataArray[indexPath.row])
                    return cell
                }
            case .loadMore:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "loading", for: indexPath) as? LoadingTableViewCell{
                    return cell
                }
        }
        
        return UITableViewCell()
    }
    
    // if pull down to call api again and append array
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == Section.loadMore.rawValue{
            setupData()
        }
    }
}


