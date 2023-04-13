//
//  CardsView.swift
//  AFMovie
//
//  Created by Alex F on 5.04.23.
//

import UIKit
import SnapKit

class CardsView: UIView {
    
    var films = [Film]()
    let backgroundView = UIImageView()
    
    enum CardSection: CaseIterable {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<CardSection, Film>?
    
    private let cardsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let layout = CustomLayout()
    var itemW: CGFloat {
        return UIScreen.viewWidth * 0.4
    }
    var itemH: CGFloat {
        return itemW * 1.45
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        setupCollectionView()
        setupConstraints()
        
        createDataSource()
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension CardsView {
    private func createFlowLayout() {
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<CardSection, Film>(collectionView: cardsCollectionView, cellProvider: { cardsCollectionView, indexPath, film -> UICollectionViewCell? in
            let cell = cardsCollectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseId, for: indexPath) as? CardCell
            cell?.configure(with: film)
            return cell
        })
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<CardSection, Film>()
        snapshot.appendSections([.main])
        snapshot.appendItems(films)
        dataSource?.apply(snapshot)
        
    }
    
    func setupScrollFirst() {
        let indexPath = IndexPath(item: 1, section: 0)
        cardsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        layout.currentPage = indexPath.item
        layout.previousOffset = layout.updateOffset(cardsCollectionView)
        if let cell = cardsCollectionView.cellForItem(at: indexPath) {
            transformCell(cell)
        }
        
    }
    
    private func setupView() {
        films = filmsMy
        backgroundView.layer.opacity = 0.5
        backgroundView.contentMode = .scaleAspectFill
        cardsCollectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.reuseId)
    }
    private func setupConstraints() {
        cardsCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
    }
    
    private func setupCollectionView() {
        cardsCollectionView.contentInsetAdjustmentBehavior = .never
        cardsCollectionView.decelerationRate = .fast
        cardsCollectionView.showsHorizontalScrollIndicator = false
        cardsCollectionView.showsVerticalScrollIndicator = false
        cardsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        cardsCollectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.reuseId)
        cardsCollectionView.dataSource = dataSource
        cardsCollectionView.delegate = self
        addSubview(cardsCollectionView)
        cardsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        cardsCollectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 50.0
        layout.minimumInteritemSpacing = 50.0
        layout.itemSize.width = itemW
        
        cardsCollectionView.backgroundView = backgroundView
        
    }
}

// MARK: - UICollectionViewDelegate

extension CardsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.item == layout.currentPage {
            print("Selected is\(indexPath)")
            
        }
        else {
            cardsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            layout.currentPage = indexPath.item
            layout.previousOffset = layout.updateOffset(cardsCollectionView)
            setupCell()
        }
    }
}

// MARK: - UICollectionViewFlowLayout

extension CardsView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemW, height: itemH)
    }
}

// MARK: - UIScrollView

extension CardsView {
    
    func setBackgroundView() {
        let indexPath = IndexPath(item: layout.currentPage, section: 0)
        if let cell = cardsCollectionView.cellForItem(at: indexPath) {
            UIView.transition(with: backgroundView, duration: 0.2, options: .transitionCrossDissolve) {
                self.backgroundView.image = self.films[self.layout.currentPage].poster
            }
        }
        layoutIfNeeded()
    }
    
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("stop anima")
        setBackgroundView()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            setupCell()
            setBackgroundView()
        }
    }
    
    private func setupCell() {
        let indexPath = IndexPath(item: layout.currentPage, section: 0)
        if let cell = cardsCollectionView.cellForItem(at: indexPath) {
            transformCell(cell)
        }
        
    }
    private func dropShadow() {
        
    }
    
    private func transformCell(_ cell: UICollectionViewCell, isEffect: Bool = true) {
        
        UIView.animate(withDuration: 0.2) {
            cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1).translatedBy(x: 0, y: -15)
        }
        
        for otherCell in cardsCollectionView.visibleCells {
            
            if let indexPath = cardsCollectionView.indexPath(for: otherCell) {
                if indexPath.item != layout.currentPage {
                    UIView.animate(withDuration: 0.2) {
                        otherCell.transform = .identity
                    }
                }
            }
        }
        
    }
}

