//
//  EntryListCell.swift
//  MobileDataUsage
//
//  Created by Jasper Alain Goce on 26/3/20.
//

import Foundation
import UIKit

class EntryListCell: UITableViewCell {
    
    var entryListData: [EntryListModel.Response.Record]?
    
    var cellDetails: EntryListModel.ViewModel.NewEntryList? {
        didSet {
            if let volume = cellDetails?.getTotalData(),
                let year = cellDetails?.year {
                textLbl.text = "\(year) Data Consumption: \(volume)"
            }
            if let decreasing = cellDetails?.decrease {
                if decreasing {
                    showDecreaseImg(true)
                } else {
                    showDecreaseImg(false)
                }
            }
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
        label.accessibilityIdentifier = "dataConsumption"
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let decreaseImg: UIImageView = {
        let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "decrease").withRenderingMode(.alwaysTemplate)
        imgView.tintColor = .red
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
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
        
        mainView.addSubview(decreaseImg)
        addConstraint(NSLayoutConstraint(
            item: decreaseImg,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: mainView,
            attribute: .centerY,
            multiplier: 1,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: decreaseImg,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: mainView,
            attribute: .trailing,
            multiplier: 1,
            constant: -16))
        addConstraint(NSLayoutConstraint(
            item: decreaseImg,
            attribute: .width,
            relatedBy: .equal,
            toItem: .none,
            attribute: .width,
            multiplier: 1,
            constant: 20))
        addConstraint(NSLayoutConstraint(
            item: decreaseImg,
            attribute: .height,
            relatedBy: .equal,
            toItem: .none,
            attribute: .height,
            multiplier: 1,
            constant: 20))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showDecreaseImg(_ show: Bool) {
        if show {
            decreaseImg.isHidden = false
            self.isUserInteractionEnabled = true
        } else {
            decreaseImg.isHidden = true
            self.isUserInteractionEnabled = false
        }
    }
    
    func showQuarterData(data: [EntryListModel.Response.Record]?) {
        if data != nil {
            var text = ""
            var ctr = 0
            _ = data!.map({
                if ctr != (data!.count - 1) {
                    text.append("\($0.quarter): \($0.volumeOfMobileData)\n")
                } else {
                    text.append("\($0.quarter): \($0.volumeOfMobileData)")
                }
                ctr += 1
            })
            textLbl.text = text
        } else {
            if let volume = cellDetails?.getTotalData() {
                textLbl.text = volume
            }
        }
        self.layoutIfNeeded()
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected == true {
                let quarterData = entryListData!.filter({
                    if let year = $0.quarter.components(separatedBy: "-").first {
                        if year == cellDetails?.year {
                            return true
                        }
                    }
                    return false
                })
                showQuarterData(data: quarterData)
            }
        }
    }
    
}
