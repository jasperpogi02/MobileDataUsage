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
    var viewModel = EntryListModel.ViewModel()
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

class EntryListCell: UITableViewCell {
    
    var cellDetails: EntryListModel.ViewModel.Entry? {
        didSet {
            
        }
    }
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.dropShadow(color: .gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textLbl: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView() {
        let view = self.contentView
        view.backgroundColor = .systemGray6
        view.addSubview(mainView)
        view.addConstraint(NSLayoutConstraint(
            item: mainView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1,
            constant: 8))
        view.addConstraint(NSLayoutConstraint(
            item: mainView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1,
            constant: -8))
        view.addConstraint(NSLayoutConstraint(
            item: mainView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: view,
            attribute: .leading,
            multiplier: 1,
            constant: 8))
        view.addConstraint(NSLayoutConstraint(
            item: mainView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: view,
            attribute: .trailing,
            multiplier: 1,
            constant: -8))
        
        mainView.addSubview(textLbl)
        addConstraint(NSLayoutConstraint(
            item: textLbl,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: mainView,
            attribute: .centerY,
            multiplier: 1,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: textLbl,
            attribute: .leading,
            relatedBy: .equal,
            toItem: mainView,
            attribute: .leading,
            multiplier: 1,
            constant: 16))
        addConstraint(NSLayoutConstraint(
            item: textLbl,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: mainView,
            attribute: .trailing,
            multiplier: 1,
            constant: -16))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
