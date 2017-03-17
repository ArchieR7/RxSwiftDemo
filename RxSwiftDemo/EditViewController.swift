//
//  EditViewController.swift
//  RxSwiftDemo
//
//  Created by 家齊 on 2017/2/22.
//  Copyright © 2017年 張家齊. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EditViewController: UIViewController {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var genderSegment: UISegmentedControl!
    @IBOutlet private weak var btnSwitch: UISwitch!
    @IBOutlet private weak var goodSwitch: UISwitch!
    @IBOutlet private weak var cheapSwitch: UISwitch!
    @IBOutlet private weak var fastSwitch: UISwitch!

    private let disposeBag = DisposeBag()
    private var currentIndex = -1
    
    var viewModel: EditViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            viewModel.name.asObservable().bindTo(nameTextField.rx.text).addDisposableTo(disposeBag)
            viewModel.email.asObservable().bindTo(emailTextField.rx.text).addDisposableTo(disposeBag)
            viewModel.genderSelected.asObservable().bindTo(genderSegment.rx.selectedSegmentIndex).addDisposableTo(disposeBag)
            nameTextField.rx.text.asObservable().bindTo(viewModel.name).addDisposableTo(disposeBag)
            emailTextField.rx.text.asObservable().bindTo(viewModel.email).addDisposableTo(disposeBag)
            genderSegment.rx.selectedSegmentIndex.asObservable().bindTo(viewModel.genderSelected).addDisposableTo(disposeBag)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("deinit EditViewController.")
    }
    

    private func setupData() {
        goodSwitch.rx.isOn.asObservable().subscribe(onNext: {
            [weak self] _ in
            self?.currentIndex = 0
        }).addDisposableTo(disposeBag)
        cheapSwitch.rx.isOn.asObservable().subscribe(onNext: {
            [weak self] _ in
            self?.currentIndex = 1
        }).addDisposableTo(disposeBag)
        fastSwitch.rx.isOn.asObservable().subscribe(onNext: {
            [weak self] _ in
            self?.currentIndex = 2
        }).addDisposableTo(disposeBag)
        Observable.combineLatest(goodSwitch.rx.isOn, fastSwitch.rx.isOn, cheapSwitch.rx.isOn, resultSelector: {
            isGood, isFast, isCheap -> Bool in
            return isGood && isFast && isCheap
        }).subscribe(onNext: {
            [weak self] isBoth in
            if isBoth {
                guard let currentIndex = self?.currentIndex else {
                    return
                }
                var random = arc4random() % 3
                while currentIndex == Int(random) {
                    random = arc4random() % 3
                }
                switch random {
                case 0:
                    self?.goodSwitch.setOn(false, animated: true)
                    self?.goodSwitch.isOn = false
                case 1:
                    self?.cheapSwitch.setOn(false, animated: true)
                    self?.cheapSwitch.isOn = false
                default:
                    self?.fastSwitch.setOn(false, animated: true)
                    self?.fastSwitch.isOn = false
                }
            }
        }).addDisposableTo(disposeBag)
    }
    
    private func setupView() {
        
    }
    
    @IBAction func clickCloseBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
