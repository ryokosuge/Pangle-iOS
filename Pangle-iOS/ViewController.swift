//
//  ViewController.swift
//  Pangle-iOS
//
//  Created by ryokosuge on 2021/01/07.
//

import UIKit
import BUAdSDK

class ViewController: UIViewController {

    @IBOutlet weak var loadButton: UIButton?
    @IBOutlet weak var showButton: UIButton?

    private var rewardedVideoAd: BURewardedVideoAd?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension ViewController {

    @IBAction private func load() {
        let videoModel = BURewardedVideoModel()
        let rewardedVideoAd = BURewardedVideoAd(slotID: Consts.Pangle.Placement.rewardedVideo,
                                                rewardedVideoModel: videoModel)
        rewardedVideoAd.delegate = self
        self.rewardedVideoAd = rewardedVideoAd
        showActivityIndicator()
        rewardedVideoAd.loadData()
    }

    @IBAction private func show() {
        rewardedVideoAd?.show(fromRootViewController: self)
    }

    private func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .systemRed
        activityIndicator.startAnimating()
        let rightButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.setRightBarButton(rightButton, animated: true)
    }

    private func hideActivityIndicator() {
        navigationItem.setRightBarButton(nil, animated: true)
    }

    private func showErrorAlert(_ error: Error?) {
        let alert = UIAlertController(title: "Error",
                                      message: error?.localizedDescription ?? "nil",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "close", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

extension ViewController: BURewardedVideoAdDelegate {

    func rewardedVideoAdDidLoad(_ rewardedVideoAd: BURewardedVideoAd) {
        print("[Pangle-iOS]", #function, rewardedVideoAd)
    }

    func rewardedVideoAd(_ rewardedVideoAd: BURewardedVideoAd, didFailWithError error: Error?) {
        print("[Pangle-iOS]", #function, rewardedVideoAd, error?.localizedDescription ?? "nil")
        showErrorAlert(error)
        hideActivityIndicator()
        showButton?.isEnabled = false
    }

    func rewardedVideoAdVideoDidLoad(_ rewardedVideoAd: BURewardedVideoAd) {
        print("[Pangle-iOS]", #function, rewardedVideoAd)
        hideActivityIndicator()
        showButton?.isEnabled = true
    }

    func rewardedVideoAdWillVisible(_ rewardedVideoAd: BURewardedVideoAd) {
        print("[Pangle-iOS]", #function, rewardedVideoAd)
    }

    func rewardedVideoAdDidVisible(_ rewardedVideoAd: BURewardedVideoAd) {
        print("[Pangle-iOS]", #function, rewardedVideoAd)
    }

    func rewardedVideoAdWillClose(_ rewardedVideoAd: BURewardedVideoAd) {
        print("[Pangle-iOS]", #function, rewardedVideoAd)
    }

    func rewardedVideoAdDidClose(_ rewardedVideoAd: BURewardedVideoAd) {
        print("[Pangle-iOS]", #function, rewardedVideoAd)
        showButton?.isEnabled = false
    }

    func rewardedVideoAdDidClick(_ rewardedVideoAd: BURewardedVideoAd) {
        print("[Pangle-iOS]", #function, rewardedVideoAd)
    }

    func rewardedVideoAdDidPlayFinish(_ rewardedVideoAd: BURewardedVideoAd, didFailWithError error: Error?) {
        print("[Pangle-iOS]", #function, rewardedVideoAd, error?.localizedDescription ?? "nil")
        showErrorAlert(error)
    }

    func rewardedVideoAdServerRewardDidSucceed(_ rewardedVideoAd: BURewardedVideoAd, verify: Bool) {
        print("[Pangle-iOS]", #function, rewardedVideoAd, "verify:  \(verify)")
    }

    func rewardedVideoAdServerRewardDidFail(_ rewardedVideoAd: BURewardedVideoAd, error: Error) {
        print("[Pangle-iOS]", #function, rewardedVideoAd, error)
        showErrorAlert(error)
    }

    func rewardedVideoAdDidClickSkip(_ rewardedVideoAd: BURewardedVideoAd) {
        print("[Pangle-iOS]", #function, rewardedVideoAd)
    }

    func rewardedVideoAdCallback(_ rewardedVideoAd: BURewardedVideoAd, with rewardedVideoAdType: BURewardedVideoAdType) {
        print("[Pangle-iOS]", #function, rewardedVideoAd, "BURewardedVideoAdType: \(rewardedVideoAdType.rawValue)")
    }

}
