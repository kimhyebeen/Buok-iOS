//
//  HomeViewController+AttributedText.swift
//  Buok
//
//  Created by Taein Kim on 2021/06/01.
//

import Foundation
import HeroCommon
import HeroUI

extension HomeViewController {
    func applyAttributedBubbleText(count: Int, filter: BucketState) {
        countDescLabel.attributedText = generateAttributedText(count: count, filter: filter)
    }
    
    func applyAttributedTotalText(count: Int) {
        let countText = "\(count < 10 ? "0" : "")\(count)"
        let text = "총 \(countText)개"
        
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .bold), range: (text as NSString).range(of: countText))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.heroPrimaryPink, range: (text as NSString).range(of: countText))
        totalLabel.attributedText = attributedStr
    }
    
    func generateAttributedText(count: Int, filter: BucketState) -> NSMutableAttributedString? {
        let countText = count < 10 ? "0\(count)" : "\(count)"
        
        switch filter {
        case .now:
            let text = "\(countText)" + "개의 버킷북을 가지고 있어요!"
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .bold), range: (text as NSString).range(of: countText))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.heroPrimaryPink, range: (text as NSString).range(of: countText))
            return attributedStr
        case .expect:
            let text = "\(countText)" + "개의 버킷북을 계획 중이에요"
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .bold), range: (text as NSString).range(of: countText))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.heroPrimaryPink, range: (text as NSString).range(of: countText))
            return attributedStr
        case .done:
            let text = "\(countText)" + "개의 버킷북 완료했어요"
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .bold), range: (text as NSString).range(of: countText))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.heroPrimaryPink, range: (text as NSString).range(of: countText))
            return attributedStr
        case.failure:
            return nil
        case .all:
            return nil
        }
    }
}
