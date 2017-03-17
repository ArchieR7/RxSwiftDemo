//
//  ImageCollectionViewCell.swift
//  RxSwiftDemo
//
//  Created by 家齊 on 2017/2/23.
//  Copyright © 2017年 張家齊. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    private var disposeBag = DisposeBag()
    
    var viewModel: ImageCollectionViewCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            titleLabel.text = viewModel.index
            disposeBag = DisposeBag()
            viewModel.image.asObservable().bindTo(imageView.rx.image).addDisposableTo(disposeBag)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

class ImageCollectionViewCellViewModel {
    var image: Variable<UIImage>
    var index: String
    
    init(index: String, url: String) {
        self.image = Variable(UIImage())
        self.index = index
        DispatchQueue.global().async {            
            WebService.shared.downloadImage(filename: url, url: url, completeHandle: {
                [weak self] response in
                guard let response = response else {
                    return
                }
                self?.image.value = response
            })
        }
    }
}
