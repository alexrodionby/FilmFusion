//
//  CardsView.swift
//  AFMovie
//
//  Created by Alex Fount on 5.04.23.
//

import UIKit
import SnapKit

class CardsView: UIView {
    var movies: [Movie] = [Movie]()

    var delegate: implementHomeVC?
    
    let backgroundView = UIImageView()
    
    enum CardSection: CaseIterable {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<CardSection, Movie>?
    
     let cardsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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
        dataSource = UICollectionViewDiffableDataSource<CardSection, Movie>(collectionView: cardsCollectionView, cellProvider: { cardsCollectionView, indexPath, movie -> UICollectionViewCell? in
            let cell = cardsCollectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseId, for: indexPath) as? CardCell
            cell?.configure(with: movie)
            return cell
        })
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<CardSection, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
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
         
        movies = [Movie(media_type: nil, id: 2, original_name: "xas", original_title: nil, poster_path: nil, overview: nil, vote_count: 8, release_date: nil, vote_average: 0.7, runtime: nil, video: true, genres: nil, adult: false, backdrop_path: nil, budget: nil, homepage: nil, original_language: "", production_companies: nil, tagline: nil, title: "dw"),
                  Movie(media_type: nil, id: 223, original_name: "xas", original_title: nil, poster_path: nil, overview: nil, vote_count: 8, release_date: nil, vote_average: 0.7, runtime: nil, video: true, genres: nil, adult: false, backdrop_path: nil, budget: nil, homepage: nil, original_language: "", production_companies: nil, tagline: nil, title: "dw"),
                  Movie(media_type: nil, id: 322, original_name: "xas", original_title: nil, poster_path: nil, overview: nil, vote_count: 8, release_date: nil, vote_average: 0.7, runtime: nil, video: true, genres: nil, adult: false, backdrop_path: nil, budget: nil, homepage: nil, original_language: "", production_companies: nil, tagline: nil, title: "dw")
        ]
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
            
            self.delegate?.pushDetailVC(from: indexPath)

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
                
                guard let url = URL(string: "https://image.tmdb.org/t/p/w500\( self.movies[self.layout.currentPage].unwrappedPosterPath )") else { return }
               
                self.backgroundView.kf.setImage(with: url)

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

