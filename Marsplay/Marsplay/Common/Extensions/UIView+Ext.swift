//
//  UIView+Ext.swift
//  Marsplay
//
//  Created by Amol Prakash on 24/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation
import UIKit

protocol Reusable: class {
  static var reuseIdentifier: String { get }
}

extension Reusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

public protocol NibLoadable: class {
  static var nib: UINib { get }
}

public extension NibLoadable {
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
  }
}

extension NibLoadable where Self: UIView {
  static func loadFromNib() -> Self {
    guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
      fatalError("The nib \(nib) expected its root view to be of type \(self)")
    }
    return view
  }
}

extension UICollectionView {
    
  final func register<T: UICollectionViewCell>(cellType: T.Type)
    where T: Reusable & NibLoadable {
      self.register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
  }
    
  final func register<T: UICollectionViewCell>(cellType: T.Type)
    where T: Reusable {
      self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
  }

  final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
    where T: Reusable {
      let bareCell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
      guard let cell = bareCell as? T else {
        fatalError(
          "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
            + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
            + "and that you registered the cell beforehand"
        )
      }
      return cell
  }

  final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String)
    where T: Reusable & NibLoadable {
      self.register(
        supplementaryViewType.nib,
        forSupplementaryViewOfKind: elementKind,
        withReuseIdentifier: supplementaryViewType.reuseIdentifier
      )
  }

  final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String)
    where T: Reusable {
      self.register(
        supplementaryViewType.self,
        forSupplementaryViewOfKind: elementKind,
        withReuseIdentifier: supplementaryViewType.reuseIdentifier
      )
  }

  final func dequeueReusableSupplementaryView<T: UICollectionReusableView>
    (ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self) -> T
    where T: Reusable {
      let view = self.dequeueReusableSupplementaryView(
        ofKind: elementKind,
        withReuseIdentifier: viewType.reuseIdentifier,
        for: indexPath
      )
      guard let typedView = view as? T else {
        fatalError(
          "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) "
            + "matching type \(viewType.self). "
            + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
            + "and that you registered the supplementary view beforehand"
        )
      }
      return typedView
  }
}

import SDWebImage
extension UIImageView {
    
    static var placeHolderImage: UIImage = #imageLiteral(resourceName: "Placeholder")
    
    func setImage(with url: String?, placeHolder: UIImage? = nil, completed: (() -> Void)? = nil) {
        if let urlString = url {
            self.sd_setImage(with: URL(string: urlString), placeholderImage: placeHolder) { (_, _, _, _) in
                completed?()
            }
        } else {
            self.image = placeHolder
        }
    }
}

extension UIApplication {
    var statusBarOrientation: UIInterfaceOrientation? {
        get {
            guard let orientation = self.windows.first?.windowScene?.interfaceOrientation else {
                return nil
            }
            return orientation
        }
    }
}
