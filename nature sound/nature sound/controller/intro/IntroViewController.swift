//
//  IntroViewController.swift
//  nature sound
//
//  Created by admin on 11/24/19.
//  Copyright © 2019 com.digimon. All rights reserved.
//

import UIKit
import SnapKit

class IntroViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let controlFrame = UIView()
    let leftControlBtn = UIButton()
    let rightControlBtn = UIButton()
    
    let backgroundImages = ["intro_1", "intro_2","intro_3", "intro_4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lauchedBefore = UserDefaults.standard.bool(forKey: "lauchedBefore")
        
//        return
        
        if lauchedBefore {
            print("lauched before")
            navigationToHome()
        } else {
            print("first run")
            UserDefaults.standard.set(true, forKey: "lauchedBefore")
            initIntroView()
        }
    }
    
    func navigationToHome() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeController") as? HomeViewController {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: false, completion: nil)
        }
    }
    
    func initIntroView() {
        self.dataSource = self
        self.delegate = self
        let initialPage = 0
        
        for imageName in backgroundImages {
            let page = IntroPageItemController()
            page.imageName = imageName
            self.pages.append(page)
        }
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        //self.transitionStyle = UIPageViewControllerTransitionStyle.Scroll
        
        // control view
        self.controlFrame.backgroundColor = UIColor(hex: "006266")
        self.view.addSubview(controlFrame)
        self.controlFrame.translatesAutoresizingMaskIntoConstraints = false
        self.controlFrame.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.controlFrame.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.controlFrame.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // left button
        self.leftControlBtn.setTitle("Prev", for: .normal)
        self.controlFrame.addSubview(leftControlBtn)
        self.leftControlBtn.translatesAutoresizingMaskIntoConstraints = false
        self.leftControlBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.leftControlBtn.leadingAnchor.constraint(equalTo: controlFrame.leadingAnchor, constant: 20).isActive = true
        self.leftControlBtn.centerYAnchor.constraint(equalTo: controlFrame.centerYAnchor).isActive = true
        self.leftControlBtn.isHidden = true
        self.leftControlBtn.addTarget(self, action: #selector(leftControlPressed), for: .touchUpInside)
        TextButtonStyles.ControlButton.apply(to: leftControlBtn)
        
        // right button
        self.rightControlBtn.setTitle("Next", for: .normal)
        self.controlFrame.addSubview(rightControlBtn)
        self.rightControlBtn.translatesAutoresizingMaskIntoConstraints = false
        self.rightControlBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.rightControlBtn.trailingAnchor.constraint(equalTo: controlFrame.trailingAnchor, constant: -20).isActive = true
        self.rightControlBtn.centerYAnchor.constraint(equalTo: controlFrame.centerYAnchor).isActive = true
        self.rightControlBtn.addTarget(self, action: #selector(rightControlPressed), for: .touchUpInside)
        TextButtonStyles.ControlButton.apply(to: rightControlBtn)
        
        // pageControl
        self.pageControl.frame = CGRect()
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = initialPage
        self.view.addSubview(self.pageControl)
        
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        self.pageControl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.pageControl.isUserInteractionEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc private func leftControlPressed() {
        if pageControl.currentPage == 0 {
            return
        } else {
            goToPreviousPage()
            self.pageControl.currentPage = self.pageControl.currentPage - 1
            updatePageControlStatus()
        }
    }
    
    @objc private func rightControlPressed() {
        if pageControl.currentPage == backgroundImages.count-1 {
            navigationToHome()
        } else {
            goToNextPage()
            self.pageControl.currentPage = self.pageControl.currentPage + 1
            updatePageControlStatus()
        }
    }
}

extension IntroViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return nil
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return nil
            }
        }
        return nil
    }
    
    //
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.index(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
            updatePageControlStatus()
        }
    }
    
    func updatePageControlStatus() {
        if (pageControl.currentPage == 0) {
            self.leftControlBtn.isHidden = true
            self.rightControlBtn.setTitle("Next", for: .normal)
        } else if (pageControl.currentPage == backgroundImages.count-1) {
            self.leftControlBtn.setTitle("Prev", for: .normal)
            self.rightControlBtn.setTitle("Done", for: .normal)
            self.leftControlBtn.isHidden = false
        } else {
            self.rightControlBtn.setTitle("Next", for: .normal)
            self.leftControlBtn.setTitle("Prev", for: .normal)
            self.leftControlBtn.isHidden = false
        }
    }
}

extension UIPageViewController {
    func goToNextPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: animated, completion: nil)
    }

    func goToPreviousPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else { return }
        setViewControllers([previousViewController], direction: .reverse, animated: animated, completion: nil)
    }

}
