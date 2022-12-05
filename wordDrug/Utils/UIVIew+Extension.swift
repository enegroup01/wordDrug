//
//  UIVIew+Extension.swift
//  wordDrug
//
//  Created by ethan on 2022/12/5.
//  Copyright © 2022 playplay. All rights reserved.
//

import Foundation

extension UIView {
    func preventMultipleClick(delay: TimeInterval = 1) {
        self.isUserInteractionEnabled = false
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false, block: { [weak self] _ in
            self?.isUserInteractionEnabled = true
        })
    }

    func changeHeight(height: CGFloat) {
        self.frame = CGRect(x: 0, y: height, width: self.frame.width, height: self.frame.height)
    }
}

public extension UIView {
    @discardableResult
    func setConstraint<LayoutType: NSLayoutAnchor<AnchorType>, AnchorType> (
        _ keyPath: KeyPath<UIView, LayoutType>,
        _ relation: NSLayoutConstraint.Relation,
        to anchor: LayoutType,
        constant: CGFloat = 0,
        mutiplier: CGFloat? = nil,
        priority: UILayoutPriority = .required
        ) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        if let mutiplier = mutiplier,
            let dimension = self[keyPath: keyPath] as? NSLayoutDimension,
            let anchor = anchor as? NSLayoutDimension {
            switch relation {
            case .equal:
                constraint = dimension.constraint(equalTo: anchor, multiplier: mutiplier, constant: constant)
            case .greaterThanOrEqual:
                constraint = dimension.constraint(greaterThanOrEqualTo: anchor, multiplier: mutiplier, constant: constant)
            case .lessThanOrEqual:
                constraint = dimension.constraint(lessThanOrEqualTo: anchor, multiplier: mutiplier, constant: constant)
            default:
                constraint = NSLayoutConstraint()
            }
        } else {
            switch relation {
            case .equal:
                constraint = self[keyPath: keyPath].constraint(equalTo: anchor, constant: constant)
            case .greaterThanOrEqual:
                constraint = self[keyPath: keyPath].constraint(greaterThanOrEqualTo: anchor, constant: constant)
            case .lessThanOrEqual:
                constraint = self[keyPath: keyPath].constraint(lessThanOrEqualTo: anchor, constant: constant)
            default:
                constraint = NSLayoutConstraint()
            }
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func setConstraint(
        _ keyPath: KeyPath<UIView, NSLayoutDimension>,
        _ relation: NSLayoutConstraint.Relation,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
        ) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        let dimension: NSLayoutDimension = self[keyPath: keyPath]
        switch relation {
        case .equal:
            constraint = dimension.constraint(equalToConstant: constant)
        case .greaterThanOrEqual:
            constraint = dimension.constraint(greaterThanOrEqualToConstant: constant)
        case .lessThanOrEqual:
            constraint = dimension.constraint(lessThanOrEqualToConstant: constant)
        default:
            constraint = NSLayoutConstraint()
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func setAnchor(
        _ keyPath: KeyPath<UIView, NSLayoutDimension>,
        _ relation: NSLayoutConstraint.Relation,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
        ) -> UIView {
        setConstraint(keyPath, relation, constant: constant, priority: priority)
        return self
    }

    @discardableResult
    func setAnchor<LayoutType: NSLayoutAnchor<AnchorType>, AnchorType> (
        _ keyPath: KeyPath<UIView, LayoutType>,
        _ relation: NSLayoutConstraint.Relation,
        to anchor: LayoutType,
        constant: CGFloat = 0,
        mutiplier: CGFloat? = nil,
        priority: UILayoutPriority = .required
        ) -> UIView {
        setConstraint(keyPath, relation, to: anchor, constant: constant, mutiplier: mutiplier, priority: priority)
        return self
    }

    func addConstraintWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for(index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UIView {

    var igLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leftAnchor
        }
        return self.leftAnchor
    }
    var igRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.rightAnchor
        }
        return self.rightAnchor
    }
    var igTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        }
        return self.topAnchor
    }
    var igBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        }
        return self.bottomAnchor
    }
    var igCenterXAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.centerXAnchor
        }
        return self.centerXAnchor
    }
    var igCenterYAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.centerYAnchor
        }
        return self.centerYAnchor
    }
//    var width: CGFloat {
//        if #available(iOS 11.0, *) {
//            return safeAreaLayoutGuide.layoutFrame.width
//        }
//        return frame.width
//    }
//    var height: CGFloat {
//        if #available(iOS 11.0, *) {
//            return safeAreaLayoutGuide.layoutFrame.height
//        }
//        return frame.height
//    }
}

