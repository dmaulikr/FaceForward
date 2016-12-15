//
//  Router.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-15.
//
//

import UIKit

class Router: NSObject {

    //MARK: Properties
    var vc: UIViewController?
    
    //MARK: Object Life Cycle
    convenience init(_ vc: UIViewController) {
        self.init()
        self.vc = vc
    }
    
    
    //MARK: Public Functions
    func showMain() {
        vc?.show(Router.mainVC(), sender: vc)
    }
    
    func showSurvey() {
        vc?.show(Router.surveyVC(), sender: vc)
    }
    
    func showPhoto() {
        vc?.show(Router.confirmPictureVC(), sender: vc)
    }
    
    func showSuggestions() {
        vc?.show(Router.suggestionsVC(), sender: vc)
    }
    
    func showChart() {
        vc?.show(Router.chartVC(), sender: vc)
    }
 

    
    
    //MARK: VCs
    fileprivate class func mainVC() -> CalendarViewController {
        return main().instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
    }
    
    fileprivate class func surveyVC() -> SurveyViewController {
        return survey().instantiateViewController(withIdentifier: "SurveyViewController") as! SurveyViewController
    }
    
    fileprivate class func confirmPictureVC() -> ConfirmPictureViewController {
        return photo().instantiateViewController(withIdentifier: "ConfirmPictureViewController") as! ConfirmPictureViewController
    }
    
    fileprivate class func suggestionsVC() -> SuggestionsViewController {
        return suggestions().instantiateViewController(withIdentifier: "SuggestionsViewController") as! SuggestionsViewController
    }
    
    fileprivate class func chartVC() -> AnalysisChartViewController {
        return chart().instantiateViewController(withIdentifier: "AnalysisChartViewController") as! AnalysisChartViewController
    }
    
 
  
    
    //MARK: Storyboards
    fileprivate class func main() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle:nil)
    }
    
    fileprivate class func survey() -> UIStoryboard {
        return UIStoryboard(name: "Survey", bundle:nil)
    }
    
    fileprivate class func photo() -> UIStoryboard {
        return UIStoryboard(name: "Photo", bundle:nil)
    }
    
    fileprivate class func suggestions() -> UIStoryboard {
        return UIStoryboard(name: "Suggestions", bundle:nil)
    }
    
    fileprivate class func chart() -> UIStoryboard {
        return UIStoryboard(name: "Chart", bundle:nil)
    }
    
    fileprivate class func musicPlayer() -> UIStoryboard {
        return UIStoryboard(name: "MusicPlayer", bundle:nil)
    }
    
}