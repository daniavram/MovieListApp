//
//  XibView.swift
//  MovieListApp
//
//  Created by daniel.avram on 23/11/2020.
//

import UIKit

class XibView: UIView {

    @IBOutlet var view: UIView!

    var nibName: String {
        return String(describing: type(of: self))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }

    private func nibSetup() {
        let bundle = Bundle(for: type(of: self))
        UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: self, options: nil)
        view.frame = bounds
        pinToWholeArea(of: view)
    }

    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let nibView = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            return nil
        }
        return nibView
    }

}
