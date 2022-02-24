//
//  HeaderView.swift
//  FakeBithumbAssignment
//
//  Created by chihoooon on 2022/02/24.
//

import UIKit

import SnapKit

final class HeaderView: UIView {

    // MARK: - Instance Property

    private let categoryLabels = ["원화", "관심"]

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "코인명 또는 심볼 검색"
        searchBar.barTintColor = .white
        return searchBar
    }()

    private let categoryView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.backgroundColor = .white
        return view
    }()

    private let settingButton: UIButton = {
        let button = UIButton()
        button.setTitle("인기", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .darkGray
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()

    private let columnNameView = ColumnNameView()

    // MARK: - Life Cycle func

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - custom func

    private func configUI() {
        configureSearchBar()
        configureCategories()
        configureSettingButton()
        configureColumnNameView()
    }

    private func configureSearchBar() {
        self.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide)
        }
    }

    private func configureCategories() {
        self.addSubview(categoryView)
        categoryView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().multipliedBy(0.7)
            $0.top.equalTo(searchBar.snp.bottom)
            $0.bottom.equalToSuperview().dividedBy(1.3)
        }
        setUpCategories()
    }

    private func setUpCategories() {
        categoryView.delegate = self
        categoryView.dataSource = self
        categoryView.register(
            CoinCategoryCell.self,
            forCellWithReuseIdentifier: CoinCategoryCell.className
        )

        let indexPath = IndexPath(item: 0, section: 0)
        categoryView.selectItem(at: indexPath, animated: false, scrollPosition: [])
    }

    private func configureSettingButton() {
        self.addSubview(settingButton)
        settingButton.showsMenuAsPrimaryAction = true
        settingButton.menu = addSettingItems()

        settingButton.snp.makeConstraints {
            $0.centerY.equalTo(categoryView)
            $0.trailing.equalToSuperview().inset(10)
        }
    }

    private func addSettingItems() -> UIMenu {
        let favorite = configureAction("인기")
        let name = configureAction("이름")
        let changeRate = configureAction("변동률")
        favorite.state = .on

        let items = UIMenu(
            title: "",
            options: .singleSelection,
            children: [favorite, name, changeRate]
        )

        return items
    }

    private func configureAction(_ title: String) -> UIAction {
        let action = UIAction(title: title) { [weak self] _ in
            self?.settingButton.setTitle(title, for: .normal)
        }

        return action
    }

    private func configureColumnNameView() {
        self.addSubview(columnNameView)
        columnNameView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(categoryView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegate

extension HeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

// MARK: - UICollectionViewDataSource

extension HeaderView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return categoryLabels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CoinCategoryCell.className,
            for: indexPath
        ) as? CoinCategoryCell
        else {
            return UICollectionViewCell()
        }
        
        cell.configureCategoryLabel(with: categoryLabels[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let size = categoryView.frame.size.height / 2
        let topBottomInsets = (categoryView.frame.size.height - size ) / 2
        return UIEdgeInsets(top: topBottomInsets, left: 10, bottom: topBottomInsets, right: 10)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let size = categoryView.frame.size.height / 2
        return CGSize(width: size, height: size)
    }
}
