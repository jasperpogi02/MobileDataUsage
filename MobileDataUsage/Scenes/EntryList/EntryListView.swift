//
//  EntryListView.swift
//  MobileDataUsage
//
//  Created by cdgtaxiMac on 3/24/20.
//

import Foundation
import UIKit

protocol EntryListViewProtocol: class {
    
}

class EntryListView: UIView {
    weak var delegate: EntryListViewProtocol?
    var viewModel: EntryListModel.ViewModel?
    var cellID = "cellID"
    lazy var dataUsageTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(EntryListCell.self, forCellReuseIdentifier: cellID)
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private func setupView() {
        self.addSubview(dataUsageTable)
        addConstraint(NSLayoutConstraint(
            item: dataUsageTable,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: dataUsageTable,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: -16))
        addConstraint(NSLayoutConstraint(
            item: dataUsageTable,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1,
            constant: 16))
        addConstraint(NSLayoutConstraint(
            item: dataUsageTable,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1,
            constant: -16))
        
    }
    
    private func setupGesture() {
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
