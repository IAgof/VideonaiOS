//
//  IntroViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import UIKit

class IntroViewController: VideonaController,
    UIPageViewControllerDelegate,
    UIPageViewControllerDataSource,
IntroViewInterface {
    
    //MARK: - VIPER
    var eventHandler: IntroPresenterInterface?
    
    //MARK: - Outlets
    @IBOutlet var nextFinishButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!

    //MARK: - Variables
    var pageViewController: UIPageViewController!

    var pageArray = ["PageOne", "PageTwo", "PageThree", "PageFour"]
    var index = 0
    
    //MARK: - Constants
    let NEXT_PAGE = "NEXT"
    let PREV_PAGE = "PREV"
    
    // MARK: - Utility Methods
    
    func getViewControllerAtIndex(index: Int) -> UIViewController? {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier(pageArray[index])
        return vc
    }
    
    func initPageViewController() {
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        let viewControllers = [getViewControllerAtIndex(0)!]
        
        
        self.pageViewController.setViewControllers(viewControllers,
                                                   direction: UIPageViewControllerNavigationDirection.Forward,
                                                   animated: false,
                                                   completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.size.height)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler?.viewDidLoad()
    }
    
    func setUpView(){
        self.initPageViewController()
        
        self.navigationController?.navigationBarHidden = true
        
        self.setSubViewsOnTop()
        
        self.pageControl.numberOfPages = pageArray.count
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
            eventHandler?.pushNext(titleLabel)
        }
    }
    
    @IBAction func pushSkipButton(sender: AnyObject) {
        print("IntroViewController pushSkipButton")
        
        eventHandler?.pushSkip()
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
        
        index += 1
        eventHandler?.onPageChange(index, size: pageArray.count)
        
        let viewControllers = [getViewControllerAtIndex(index)!]
        self.pageViewController.setViewControllers(viewControllers,
                                                   direction: UIPageViewControllerNavigationDirection.Forward,
                                                   animated: true,
                                                   completion: nil)
    }
    
    func changeNextFinishButtonTitle(title:String){
        self.nextFinishButton.setTitle(title, forState: .Normal)
    }
    
    func changeSkipButtonTittle(title:String){
        self.skipButton.setTitle(title, forState: .Normal)
    }
    func updateCurrentPage(page:Int){
        self.pageControl.currentPage = page
    }
    
    func updateConstaintsOnView() {
         pageViewController.view.setNeedsUpdateConstraints()
    }
    // MARK: - Page View Controller Data Source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        
        if (index == 0)
        {
            return nil
            
        }
        
        index -= 1
        eventHandler?.onPageChange(index, size: pageArray.count)
        return getViewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        index += 1
        eventHandler?.onPageChange(index, size: pageArray.count)

        if (index >= self.pageArray.count)
        {
            index -= 1
            return nil
        }
        
        return getViewControllerAtIndex(index)
        
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return self.pageArray.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
}
