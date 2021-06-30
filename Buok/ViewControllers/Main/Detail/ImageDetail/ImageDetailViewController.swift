//
//  ImageDetailViewController.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI
import Kingfisher
import SnapKit

final class ImageDetailViewController: HeroBaseViewController {
    // MARK: Title Bar Section

    private var titleBar = UIView()
    private var pageLabel = UILabel()
    private var closeButton = UIButton()

    private var scrollView = UIScrollView()
    private var images: [UIImage]?
    var attachments: [String]?

    var prevCurrentPage: Int = 0

    var currentPage: Int = 0 {
        didSet {
            scrollToPage(page: currentPage, animated: false)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainLayout()
    }

    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        scrollView.scrollRectToVisible(frame, animated: animated)
    }

    private func setupMainLayout() {
        let viewHeight: CGFloat = view.bounds.size.height
        let viewWidth: CGFloat = view.bounds.size.width

        navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = .black

        view.addSubview(scrollView)
        view.addSubview(titleBar)
        titleBar.addSubview(pageLabel)
        titleBar.addSubview(closeButton)

        titleBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }

        pageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        pageLabel.textColor = .heroBlue100s
        pageLabel.font = .font15PBold
        setPageTitle(title: "\(currentPage + 1) / \(attachments?.count ?? 0)", boldTitle: "\(attachments?.count ?? 0)")

        closeButton.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(closeButton.snp.height)
        }

        closeButton.setImage(UIImage(heroSharedNamed: "ic_x")?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.addTarget(self, action: #selector(onClickClose(_:)), for: .touchUpInside)

        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }

        scrollView.isPagingEnabled = true

        var xPostion: CGFloat = 0
        if let imageUrls = attachments {
            for urlString in imageUrls {
                let view = UIView(frame: CGRect(x: xPostion, y: 0, width: viewWidth, height: viewHeight))
                xPostion += viewWidth
                let imageView = ZoomableImageView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))

                imageView.setup()
                imageView.zoomableImageViewDelegate = self
                imageView.imageContentMode = .aspectFit
                imageView.initialOffset = .center
                imageView.display(imageUrl: URL(string: urlString)!)

                view.addSubview(imageView)
                scrollView.addSubview(view)
            }
        }
        scrollView.contentSize = CGSize(width: xPostion, height: viewHeight)
        scrollView.delegate = self
        scrollToPage(page: currentPage, animated: false)
    }

    @objc
    private func onClickClose(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @objc
    private func onClickSave(_: UIButton) {
        let page = Int(currentPage)
//        showProgressBar()

        guard let attachments = attachments else {
            return
        }

        let urlString = attachments[page]

        if let url = URL(string: urlString),
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data)
        {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }

    @objc func image(_: UIImage, didFinishSavingWithError error: NSError?, contextInfo _: UnsafeRawPointer) {
//        hideProgressBar()

        if error != nil {
            let acM = UIAlertController(title: NSLocalizedString("saveErrorTitle", comment: ""), message: NSLocalizedString("saveErrorMessage", comment: ""), preferredStyle: .alert)
            acM.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
            present(acM, animated: true)
        } else {
            let acM = UIAlertController(title: NSLocalizedString("saveCompleteTitle", comment: ""), message: NSLocalizedString("saveCompleteMessage", comment: ""), preferredStyle: .alert)
            acM.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
            present(acM, animated: true)
        }
    }

    private func setPageTitle(title: String, boldTitle: String) {
        let boldHighlightAttribute = [
            NSAttributedString.Key.font: UIFont.font15P,
            NSAttributedString.Key.foregroundColor: UIColor.white,
        ]

        pageLabel.text = title
        pageLabel.setAttributedText(title, targetText: "/ \(boldTitle)", attributes: boldHighlightAttribute)
    }
}

extension ImageDetailViewController: ZoomableImageViewDelegate {
    func zoomableImageViewDidChangeOrientation(imageView _: ZoomableImageView) {}

    func zoomableImageViewDidLoadImage(imageView _: ZoomableImageView) {
        scrollToPage(page: currentPage, animated: false)
    }

    func scrollViewDidEndZooming(_: UIScrollView, with _: UIView?, atScale _: CGFloat) {}

    func scrollViewDidScroll(_: UIScrollView) {}

    func scrollViewDidEndDragging(_: UIScrollView, willDecelerate _: Bool) {}

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = scrollView.currentScrollPage
        if scrollView.zoomScale == 1 {
            DebugLog("scrollViewDidEndDecelerating: \(currentPage) \(scrollView.zoomScale) / \(scrollView.maximumZoomScale) / \(scrollView.bouncesZoom)")
            setPageTitle(title: "\(currentPage) / \(attachments?.count ?? 0)", boldTitle: "\(attachments?.count ?? 0)")
        }
    }
}

extension UIScrollView {
    var currentScrollPage: Int {
        return Int((contentOffset.x + (0.5 * frame.size.width)) / frame.width) + 1
    }
}
