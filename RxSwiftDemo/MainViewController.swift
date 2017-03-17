//
//  MainViewController.swift
//  RxSwiftDemo
//
//  Created by 家齊 on 2017/2/22.
//  Copyright © 2017年 張家齊. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    private let user = User()
    private let disposeBag = DisposeBag()
    private let image: Variable<UIImage?> = Variable(UIImage())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupData() {

        let editBtn = UIBarButtonItem(title: "編輯", style: .plain, target: self, action: #selector(MainViewController.clickEditBtn(_:)))
        navigationItem.rightBarButtonItem = editBtn
        let collectionBtn = UIBarButtonItem(title: "圖片", style: .plain, target: self, action: #selector(MainViewController.clickImageBtn(_:)))
        navigationItem.leftBarButtonItem = collectionBtn
        DispatchQueue.global().async {
            WebService.shared.downloadImage(filename: "https://developer.apple.com/swift/images/swift-og.png", url: "https://developer.apple.com/swift/images/swift-og.png", completeHandle: {
                [weak self] response in
                self?.image.value = response
            })
        }
        image.asObservable().bindTo(imageView.rx.image).addDisposableTo(disposeBag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    private func setupView() {
        user.name.asObservable().bindTo(nameLabel.rx.text).addDisposableTo(disposeBag)
        user.gender.asObservable().map({
            gender -> String in
            switch gender {
            case .female:
                return "女生"
            case .male:
                return "男生"
            }
        }).bindTo(genderLabel.rx.text).addDisposableTo(disposeBag)
        user.emial.asObservable().bindTo(emailLabel.rx.text).addDisposableTo(disposeBag)
    }
    
    func clickEditBtn(_ sender: UIBarButtonItem) {
        let editViewController = EditViewController(nibName: EditViewController.className, bundle: nil)
        present(editViewController, animated: true, completion: nil)
        editViewController.viewModel = EditViewModel(user: user)
    }
    
    func clickImageBtn(_ sender: UIBarButtonItem) {
        let imageViewController = ImageCollectionViewController(nibName: ImageCollectionViewController.className, bundle: nil)
        show(imageViewController, sender: self)
    }
}
