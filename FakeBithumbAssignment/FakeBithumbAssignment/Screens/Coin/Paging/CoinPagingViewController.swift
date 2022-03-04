//
//  CoinPagingViewController.swift
//  FakeBithumbAssignment
//
//  Created by 박예빈 on 2022/02/26.
//

import UIKit

import SnapKit
import Then

enum TabView: Int{
    case quote, graph, contractDetails
}

final class CoinPagingViewController: UIPageViewController {
    
    // MARK: - Instance Property
    private var pages : [TabView: UIViewController] = [
        .quote: CoinQuoteInformationTabViewController(),
        .graph: CandleStickChartTabViewController(),
        .contractDetails: CoinContractDetailsTabViewController()
    ]

    // MARK: - Life Cycle func
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation,
                  options: [UIPageViewController.OptionsKey : Any]? = nil
    ) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeTabViewController()
        self.setFirstShowViewController()
    }
    
    
    // MARK: - custom funcs
    
    private func makeTabViewController() {
//        self.pages = [
//            .quote: CoinQuoteInformationTabViewController(),
//            .graph: CoinGraphTabViewController(),
//            .contractDetails: CoinContractDetailsTabViewController()
//        ]
    }
    
    private func setFirstShowViewController() {
        self.setTabViewController(to: .quote)
    }
    
    func setTabViewController(to type: TabView) {
        guard let page = pages[type] else { return }
        self.setViewControllers([page], direction: .forward, animated: false, completion: nil)
    }
}
