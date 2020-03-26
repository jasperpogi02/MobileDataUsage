//
//  EntryListViewController.swift
//  MobileDataUsage
//
//  Created by cdgtaxiMac on 3/24/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol EntryListDisplayLogic: class {
    func displayEntryList(viewModel: EntryListModel.ViewModel)
    func displayError(errorMsg: String)
}

class EntryListViewController: UIViewController, EntryListDisplayLogic, EntryListViewProtocol {
    var interactor: EntryListBusinessLogic?
    var router: (NSObjectProtocol & EntryListRoutingLogic & EntryListDataPassing)?
    
    lazy var myView: EntryListView = {
        let view = EntryListView()
        view.delegate = self
        view.dataUsageTable.delegate = self
        view.dataUsageTable.dataSource = self
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = EntryListInteractor()
        let presenter = EntryListPresenter()
        let router = EntryListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupView() {
        edgesForExtendedLayout = []
        navigationController?.navigationBar.backgroundColor = .systemGray
        view.addSubview(myView)
        view.addConstraint(NSLayoutConstraint(
            item: myView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1,
            constant: 0))
        view.addConstraint(NSLayoutConstraint(
            item: myView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1,
            constant: 0))
        view.addConstraint(NSLayoutConstraint(
            item: myView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: view,
            attribute: .trailing,
            multiplier: 1,
            constant: 0))
        view.addConstraint(NSLayoutConstraint(
            item: myView,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1,
            constant: 0))
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupView()
        getEntryData()
    }
    
    // MARK: Event Handling
    
    func getEntryData() {
        interactor?.getEntryData()
    }
    
    // MARK: Display Handling
    
    func displayEntryList(viewModel: EntryListModel.ViewModel) {
        myView.viewModel = viewModel
        DispatchQueue.main.async {
            self.myView.dataUsageTable.reloadData()
        }
    }
    
    func displayError(errorMsg: String) {
        let alertController = UIAlertController(title: "Error Occured", message: errorMsg, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension EntryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return myView.viewModel?.groupedListData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myView.cellID, for: indexPath) as! EntryListCell
        cell.cellDetails = myView.viewModel?.groupedListData[indexPath.section]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    

}
