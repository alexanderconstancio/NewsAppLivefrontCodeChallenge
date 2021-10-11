//
//  Ext-ArticleBodyCVFunctions.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/10/21.
//

import Foundation
import UIKit

extension ArticleBodyViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        articleParagraphs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let paraCell = collectionView.dequeueReusableCell(withReuseIdentifier: bodyCellID, for: indexPath) as! ArticleBodyCell
        let articleParagraphs = articleParagraphs[indexPath.item]
        paraCell.paragraphString = articleParagraphs
        return paraCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let articleParagraphs = articleParagraphs[indexPath.item]
        let frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: 200)
        let dummyCell = ArticleBodyCell(frame: frame)
        
        dummyCell.paragraphString = articleParagraphs
        dummyCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: collectionView.frame.width, height: 2000)
        let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
        
        return CGSize(width: collectionView.frame.width, height: estimatedSize.height)
    }
}
