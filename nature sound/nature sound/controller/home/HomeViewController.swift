import UIKit
import Toast_Swift
//import GoogleMobileAds

class HomeViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate/*, GADBannerViewDelegate*/
{
    var PAGE_COUNT = 5
    
    let favoriteIdentifier = "FavoritePage"
    let collectionIdentifier = "CollectionSoundsPage"
    let pageControllerIdentifier = "PageViewController"
    
//    var bannerView: GADBannerView!
    var testView = UIView()
    
    var identifiers: NSArray = ["FavoritePage", "CollectionSoundsPage"]
    //rain - nature - farm - city - relax
    var controllers : [CollectionSoundViewController] = []
    var favoriteController : FavoritesViewController!
    //var index = 0
    var mControllView: ControllView! = nil
    var pageControl = UIPageControl()
    
    var nextIndex = 0
    
    fileprivate var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initControllers()
        
        let pageController = self.storyboard!.instantiateViewController(withIdentifier: pageControllerIdentifier) as! UIPageViewController
        pageController.dataSource = self
        pageController.delegate = self
        
        let pageStart = viewControllerAtIndex(0)!
        let pages = [pageStart]
        
        pageController.setViewControllers(pages, direction: .forward, animated: true, completion: nil)
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParentViewController: self)

        registerObserver()
        initPageControl()
//        initAds()
    }
    
    func registerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(onSoundControl(_:)), name: Notification.Name.playSound, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onCloseAll(_:)), name: Notification.Name.closeAllSound, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSettingSounds), name: Notification.Name.settingSounds, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onMaxSound), name: Notification.Name.maxSound, object: nil)
    }
    
    // turn off all sound are playing
    @objc func onCloseAll(_ notification: Notification) {
        for soundId in SoundManager.shared.listSoundPlaying.keys {
            let userInfo:[String:String] = ["id": soundId]
            NotificationCenter.default.post(name: .closeSound, object: nil, userInfo: userInfo)
        }
        SoundManager.shared.stopAllSound()
        updateControllView()
    }
    
    //
    @objc func onSoundControl(_ notification: Notification) {
        guard let sound = notification.userInfo?["sound"] as? PlaySoundItem else { return }
        if sound.isPlaying {
            SoundManager.shared.playSound(object: sound)
        } else {
            SoundManager.shared.stopSound(id: sound.sound.id)
        }
        //self.view.makeToast
        updateControllView()
    }
    
    @objc func onMaxSound() {
        let toastText = NSLocalizedString("limit_sound_playing" , comment: "")
        self.view.makeToast(toastText, duration: 3.0, position: .bottom)
    }
    
    @objc func showSettingSounds() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        let contentViewController = SoundsSettingController()
        contentViewController.preferredContentSize = contentViewController.view.bounds.size
        alertController.setValue(contentViewController, forKey: "contentViewController")
        present(alertController, animated: true, completion: nil)
    }
    
    func initControllers() {
        for i in 0...(PAGE_COUNT - 1) {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: identifiers[1] as! String) as! CollectionSoundViewController
            controller.setIndex(index: i)
            self.controllers.append(controller)
        }
    }
    
    func viewControllerAtIndex(_ index:Int)->UIViewController? {
        return controllers[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = 0
        
        if viewController is CollectionSoundViewController {
            index = (viewController as! CollectionSoundViewController).index
        }
        
        //if the index is 0, return nil since we dont want a view controller before the first one
        if index == 0 {
            return nil
        }
        return self.viewControllerAtIndex(index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        var index = 0
        if viewController is CollectionSoundViewController {
            index = (viewController as! CollectionSoundViewController).index
        }
        
        if index == PAGE_COUNT - 1 {
            return nil
        }
        
        return self.viewControllerAtIndex(index + 1)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return PAGE_COUNT
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return 0
    }
    
    private func updateControllView() {
        if mControllView == nil {
            let px = self.view.bounds.width/2 - 70
            let py = self.view.bounds.height - 100
            mControllView = ControllView(frame: CGRect(x: px, y: py, width: 140, height: 50))
            self.view.addSubview(mControllView)
        }
        
        if SoundManager.shared.listSoundPlaying.count > 0 {
            showControl()
            mControllView.isHidden = false
        } else {
            hideControl()
            mControllView.isHidden = true
        }
        mControllView.updateCount(count: SoundManager.shared.listSoundPlaying.count)
//        Singleton.shared.numberSoundPlaying = listSoundPlaying.count
    }
    
    func hideControl() {
        UIView.animate(withDuration: 0.5, animations: {self.mControllView.alpha = 0}, completion: { finished in self.mControllView.isHidden = true})
    }
    
    func showControl () {
        UIView.animate(withDuration: 0.5, animations: {self.mControllView.alpha = 1}, completion: { finished in self.mControllView.isHidden = false})
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        if (!completed) {
            return
        }
        pageControl.currentPage = nextIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        guard let nextViewController = pendingViewControllers[0] as? CollectionSoundViewController else {
            return
        }
        nextIndex = nextViewController.index
    }
    
    func initPageControl() {
        // pageControl
        self.pageControl.frame = CGRect()
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.numberOfPages = controllers.count
        self.pageControl.currentPage = 0
        self.view.addSubview(self.pageControl)
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
//    func initAds() {
//        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
//        bannerView.delegate = self
//        addBannerViewToView(bannerView)
//        bannerView.adUnitID = HOME_ADS_STRING //"ca-app-pub-3940256099942544/2934735716"//
//        bannerView.rootViewController = self
//        bannerView.load(GADRequest())
//    }
    
//    func addBannerViewToView(_ bannerView: GADBannerView) {
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(bannerView)
//        view.addConstraints(
//            [NSLayoutConstraint(item: bannerView,
//                                attribute: .bottom,
//                                relatedBy: .equal,
//                                toItem: view.safeAreaLayoutGuide.bottomAnchor ,
//                                attribute: .top,
//                                multiplier: 1,
//                                constant: 0),
//             NSLayoutConstraint(item: bannerView,
//                                attribute: .centerX,
//                                relatedBy: .equal,
//                                toItem: view,
//                                attribute: .centerX,
//                                multiplier: 1,
//                                constant: 0)
//            ])
//    }
    
    /// Tells the delegate an ad request loaded an ad.
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        print("adViewDidReceiveAd")
//
//        // not work
////        self.pageViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
//    }


}

