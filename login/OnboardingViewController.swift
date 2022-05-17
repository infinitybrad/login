//
//  OnboardingViewController.swift
//  login
//
//  Created by brad on 2022/05/18.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift


class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    private let bag = DisposeBag()
    private var currentPosition:Int =  0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //navigationController?.isNavigationBarHidden = true
        self.initCollectionView()
        self.binding()
        
    }
    
    private func initCollectionView()
    {
        let collectionViewLayer = UICollectionViewFlowLayout()
        collectionViewLayer.minimumLineSpacing = 0
        collectionViewLayer.scrollDirection  = .horizontal
        collectionViewLayer.itemSize = CGSize(width: self.view.frame.width , height: self.view.frame.height)
        
        collectionView.setCollectionViewLayout(collectionViewLayer, animated: false)
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier:OnboardingCell.identifier )
        self.collectionView.isPagingEnabled = true
        self.collectionView.rx.setDelegate(self)
            .disposed(by: bag)
    }
    
    
    private func binding()
    {
        let onboardingObservable: Observable<[OnboardingModel]> = Observable.of(self.createOnboardingData())
        onboardingObservable
            .bind(to:collectionView.rx.items(cellIdentifier: OnboardingCell.identifier, cellType: OnboardingCell.self)){
                (index , data , cell) in
                cell.bind(data)
            }
            .disposed(by: bag)
        
        
        
        nextButton.rx.tap.asDriver()
            .drive(onNext:{ [weak self] in
                
                self?.currentPosition += 1
                if self?.currentPosition == 2
                {
                    self?.loginButton.isHidden = true
                    self?.nextButton.setTitle("Login", for: .normal)
                    self?.collectionView.scrollToItem(at: IndexPath(row: self?.currentPosition ?? 0, section: 0),
                                                      at: .centeredHorizontally, animated: true)
                }
                else if self?.currentPosition == 3
                {
                    self?.currentPosition = 2
                    print("go Login")
                    
                }
                else
                {
                    self?.loginButton.isHidden = false
                    self?.nextButton.setTitle("Next", for: .normal)
                    self?.collectionView.scrollToItem(at: IndexPath(row: self?.currentPosition ?? 0, section: 0),
                                                      at: .centeredHorizontally, animated: true)
                }
                
                
            })
            .disposed(by: bag)

        
        loginButton.rx.tap.asDriver()
            .drive(onNext:{ [weak self] in
                
              
                
            })
            .disposed(by: bag)
    }
    
    private func createOnboardingData() -> [OnboardingModel]
    {
        var models:[OnboardingModel] = [OnboardingModel]()
        
        let step1 = OnboardingModel.init(imageNamed: "unsplash_FWVMhUa_wbY", step: "TTV A.I Step.1", title: "Type the text you want to make a video of", description: "TTV A.I allows you to produce images using only text.Image clips are created based on paragraphs (line changes)")
        
        let step2 = OnboardingModel.init(imageNamed: "unsplash_FWVMhUa_wbY", step: "TTV A.I Step.2", title: "Automatic video mach, sound, subtitle generation", description: "Do you want to make the video richer? Change the image and add sound through simple editing.")
        
        
        let step3 = OnboardingModel.init(imageNamed: "unsplash_kLmt1mpGJVg", step: "TTV A.I Step.3", title: "Download videos and upload them on SNS", description: "Download autocomplete videos or upload them to various platforms through SNS upload function.")
        
        models.append(step1)
        models.append(step2)
        models.append(step3)
        
        return models
    }
    
    
  
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = self.collectionView.contentOffset
        visibleRect.size = self.collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = self.collectionView.indexPathForItem(at: visiblePoint) else { return }
        
        
        self.currentPosition = indexPath.row
        if indexPath.row == 2
        {
            self.loginButton.isHidden = true
            self.nextButton.setTitle("Login", for: .normal)
        }
        else
        {
            self.loginButton.isHidden = false
            self.nextButton.setTitle("Next", for: .normal)
        }
    }
    
    
}

