//
//  ImageCollectionViewController.swift
//  RxSwiftDemo
//
//  Created by 家齊 on 2017/2/23.
//  Copyright © 2017年 張家齊. All rights reserved.
//

import UIKit

class ImageCollectionViewController: UIViewController {

    @IBOutlet private weak var imageCollectionView: UICollectionView!
    @IBOutlet private weak var collecitonViewFlowLayout: UICollectionViewFlowLayout!
    
    var urls = ["https://s3.amazonaws.com/digitaltrends-uploads-prod/2016/02/NBA-Header.jpg",
                "https://i.imgur.com/J1EpojFb.jpg",
                "https://i.imgur.com/roI7e1Ib.jpg",
                "https://i.imgur.com/D7in05Tb.jpg",
                "https://s3.amazonaws.com/digitaltrends-uploads-prod/2016/02/NBA-Header.jpg",
                "https://i.imgur.com/rssDwoSb.jpg",
                "https://s3.amazonaws.com/digitaltrends-uploads-prod/2016/02/NBA-Header.jpg",
                "https://i.imgur.com/PqCSW5Rb.jpg",
                "https://i.imgur.com/RiEZ9uWb.jpg",
                "https://s3.amazonaws.com/digitaltrends-uploads-prod/2016/02/NBA-Header.jpg",
                "https://i.imgur.com/J1EpojFb.jpg",
                "https://i.imgur.com/roI7e1Ib.jpg",
                "https://i.imgur.com/D7in05Tb.jpg",
                "https://s3.amazonaws.com/digitaltrends-uploads-prod/2016/02/NBA-Header.jpg",
                "https://i.imgur.com/rssDwoSb.jpg",
                "https://i.imgur.com/O33Du4fb.jpg",
                "https://i.imgur.com/PqCSW5Rb.jpg",
                "https://i.imgur.com/RiEZ9uWb.jpg",
                "https://i.imgur.com/2gwckgsb.jpg",
                "https://i.imgur.com/J1EpojFb.jpg",
                "https://i.imgur.com/roI7e1Ib.jpg",
                "https://i.imgur.com/D7in05Tb.jpg",
                "https://i.imgur.com/D3AdHWRb.jpg",
                "https://i.imgur.com/rssDwoSb.jpg",
                "https://i.imgur.com/O33Du4fb.jpg",
                "https://i.imgur.com/PqCSW5Rb.jpg",
                "https://i.imgur.com/RiEZ9uWb.jpg",
                "https://i.imgur.com/2gwckgsb.jpg",
                "https://i.imgur.com/J1EpojFb.jpg",
                "https://i.imgur.com/roI7e1Ib.jpg",
                "https://i.imgur.com/D7in05Tb.jpg",
                "https://i.imgur.com/D3AdHWRb.jpg",
                "https://i.imgur.com/rssDwoSb.jpg",
                "https://i.imgur.com/O33Du4fb.jpg",
                "https://i.imgur.com/PqCSW5Rb.jpg",
                "https://i.imgur.com/RiEZ9uWb.jpg",
                "https://i.imgur.com/2gwckgsb.jpg",
                "https://i.imgur.com/J1EpojFb.jpg",
                "https://i.imgur.com/roI7e1Ib.jpg",
                "https://i.imgur.com/D7in05Tb.jpg",
                "https://i.imgur.com/D3AdHWRb.jpg",
                "https://i.imgur.com/rssDwoSb.jpg",
                "https://i.imgur.com/O33Du4fb.jpg",
                "https://i.imgur.com/PqCSW5Rb.jpg",
                "https://i.imgur.com/RiEZ9uWb.jpg",
                "https://i.imgur.com/2gwckgsb.jpg",
                "https://i.imgur.com/J1EpojFb.jpg",
                "https://i.imgur.com/roI7e1Ib.jpg",
                "https://i.imgur.com/D7in05Tb.jpg",
                "https://i.imgur.com/D3AdHWRb.jpg",
                "https://i.imgur.com/rssDwoSb.jpg",
                "https://i.imgur.com/O33Du4fb.jpg",
                "https://i.imgur.com/PqCSW5Rb.jpg",
                "https://i.imgur.com/RiEZ9uWb.jpg",
                "https://i.imgur.com/2gwckgsb.jpg",
                "https://i.imgur.com/J1EpojFb.jpg",
                "https://i.imgur.com/roI7e1Ib.jpg",
                "https://i.imgur.com/D7in05Tb.jpg",
                "https://i.imgur.com/D3AdHWRb.jpg",
                "https://i.imgur.com/rssDwoSb.jpg",
                "https://i.imgur.com/O33Du4fb.jpg",
                "https://i.imgur.com/PqCSW5Rb.jpg",
                "https://i.imgur.com/RiEZ9uWb.jpg"]
    var cellViewModels = [ImageCollectionViewCellViewModel]()
    
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
    
    private func setupData() {
        cellViewModels = urls.enumerated().map({
            index, string in
            return ImageCollectionViewCellViewModel(index: index.description, url: string)
        })
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(cellType: ImageCollectionViewCell.self)
    }
    
    private func setupView() {
        collecitonViewFlowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 20) / 3 , height: (UIScreen.main.bounds.size.width - 20) / 3 + 30)
    }
    
    deinit {
        print("deinit imageCollectionViewController.")
    }
}

extension ImageCollectionViewController: UICollectionViewDelegate {
    
}

extension ImageCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ImageCollectionViewCell.self, for: indexPath)
        cell.viewModel = cellViewModels[indexPath.row]
        return cell
    }
    
}
