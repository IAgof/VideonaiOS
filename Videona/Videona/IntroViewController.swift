//
//  IntroViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController,
    UIPageViewControllerDelegate,
    UIPageViewControllerDataSource,
IntroViewInterface {
    
    //MARK: - VIPER
    var introPresenter: IntroPresenterInterface?
    
    //MARK: - Outlets
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet var nextFinishButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    
    var pageArray = ["PageOne", "PageTwo", "PageThree", "PageFour"]
    var index = 0
    var pageViewController: UIPageViewController!
    
    //MARK: - Constants
    let NEXT_PAGE = "NEXT"
    let PREV_PAGE = "PREV"
    
    // MARK: - Utility Methods
    
    func getViewControllerAtIndex(index: Int) -> UIViewController? {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier(pageArray[index])
        return vc
    }
    
    
    
    // MARK: - PageViewController delegate methods
    
    // Returns the View Controller before the current view controller
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var currentIndex: Int? = nil
        if let id = viewController.restorationIdentifier {
            currentIndex = pageArray.indexOf(id)!
        }
        
        introPresenter?.onPageChange(currentIndex!, size: pageArray.count)
        
        if currentIndex! > 0 {
            let currentPage = currentIndex! - 1
            return getViewControllerAtIndex(currentPage)
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var currentIndex: Int? = nil
        if let id = viewController.restorationIdentifier {
            currentIndex = pageArray.indexOf(id)!
        }
        introPresenter?.onPageChange(currentIndex!, size: pageArray.count)
        
        if currentIndex! < pageArray.count - 1 {
            let currentPage = currentIndex! + 1
            return getViewControllerAtIndex(currentPage)
        }
        
        return nil
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        
        let viewControllers = [getViewControllerAtIndex(0)!]
        self.pageViewController.setViewControllers(viewControllers,
                                                   direction: UIPageViewControllerNavigationDirection.Forward,
                                                   animated: false,
                                                   completion: nil)
        
        self.pageViewController.didMoveToParentViewController(self)
        
        self.setSubViewsOnTop()
        
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = pageArray.count
        
        self.navigationController?.navigationBarHidden = true
        
    }
    
    func setSubViewsOnTop(){
        self.view.bringSubviewToFront(self.pageControl)
        self.view.bringSubviewToFront(self.nextFinishButton)
        self.view.bringSubviewToFront(self.skipButton)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - OnPush Actions
    
    @IBAction func pushNextButton(sender: AnyObject) {
        if let titleLabel = (nextFinishButton.titleLabel?.text){
            introPresenter?.pushNext(titleLabel)
        }
    }
    
    @IBAction func pushSkipButton(sender: AnyObject) {
        print("IntroViewController pushSkipButton")
        
        introPresenter?.pushSkip()
    }
    
    func getCurrentIndexViewFromArray(viewController: UIViewController) -> Int{
        var currentIndex: Int? = nil
        // Now find the id of the current view controller in the array
        if let id = viewController.restorationIdentifier {
            // Get the index of the current view controller id in array
            currentIndex = pageArray.indexOf(id)!
        }
        return currentIndex!
    }
    
    //MARK: - Interface
    func goToNextView() {
        
        let index = getCurrentIndexViewFromArray(self.pageViewController.viewControllers![0]) + 1
        introPresenter?.onPageChange(index, size: pageArray.count)
        
        let viewControllers = [getViewControllerAtIndex(index)!]
        self.pageViewController.setViewControllers(viewControllers,
                                                   direction: UIPageViewControllerNavigationDirection.Forward,
                                                   animated: true,
                                                   completion: nil)
    }
    
    func changeNextFinishButtonTitle(title:String){
        self.nextFinishButton.setTitle(title, forState: .Normal)
    }
    
    func updateCurrentPage(page:Int){
        self.pageControl.currentPage = page
    }
}
