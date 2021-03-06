//
//  Delegate.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-20.
//
//

import UIKit
import JTAppleCalendar
import RealmSwift

class Delegate: NSObject, JTAppleCalendarViewDelegate {
   
    //MARK: Properties
    var moodData: Results<DataEntry>?
    weak var delegate:calendarEventHandlingProtocol?
    let dateFormatter = DateFormatter()
    let myDateFormatter = MyDateFormatter()
    
    //MARK: All cells in a month
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        
        let myCustomCell = cell as! CellView
        myCustomCell.backgroundColor = UIColor.clear
        
        // Current date color
        dateFormatter.dateFormat = "yyy MM dd"
        let currentDateString = dateFormatter.string(from: Date())
        let cellStateDateString = dateFormatter.string(from: cellState.date)
        
        if  currentDateString ==  cellStateDateString {
            markCurrentDate(cell: myCustomCell)
        } else {
            myCustomCell.currentColor.isHidden = true
        }
        
        var circleColor : UIColor?
        
        // Mood colors
        for moodDate in moodData!{
            let startOfDay = Calendar.current.startOfDay(for: moodDate.date)
            if startOfDay == cellState.date {
                let emotionToday = moodDate.emotion[0].largestEmotion
                let color = setCalendarCellColor(colorMood: emotionToday)
                myCustomCell.moodColor.backgroundColor = color
                circleColor = color
                myCustomCell.moodColor.isHidden = false
                break
            }
            else {
                myCustomCell.moodColor.isHidden = true
            }
        }
        
        //Days to display
        myCustomCell.dayLabel.text = cellState.text
        
        if cellState.dateBelongsTo == .thisMonth {
            myCustomCell.isHidden = false
        } else {
            myCustomCell.isHidden = true
        }

        myCustomCell.layoutIfNeeded()
        let radius1 = min((myCustomCell.subviews.first?.frame.size.width)!, (myCustomCell.subviews.first?.frame.size.height)!) / 2.0
        myCustomCell.subviews.first?.layer.cornerRadius = radius1
        
        let radius2 = min(myCustomCell.subviews[1].frame.size.width, myCustomCell.subviews[1].frame.size.height) / 2.0
        myCustomCell.subviews[1].layer.cornerRadius =  radius2
    
        let newWidth1 = min((myCustomCell.subviews.first?.frame.size.width)!, (myCustomCell.subviews.first?.frame.size.height)!)
        myCustomCell.subviews.first?.frame.size.width = newWidth1
        myCustomCell.subviews.first?.center = myCustomCell.center
        
        let newWidth2 = min(myCustomCell.subviews[1].frame.size.width, myCustomCell.subviews[1].frame.size.height)
        myCustomCell.subviews[1].frame.size.width = newWidth2
        myCustomCell.subviews[1].center = myCustomCell.center
    }
    
    func markCurrentDate(cell: CellView) {
        
        cell.currentColor.backgroundColor = UIColor.white
        cell.currentColor.isHidden = false
    }
    
    func setCalendarCellColor(colorMood: String) -> UIColor {
        
        switch colorMood {
        case "anger":
            return Styling.Colors.brightPinkColor
        case "contempt":
            return Styling.Colors.orangeColor
        case "disgust":
            return Styling.Colors.redColor
        case "fear":
            return Styling.Colors.darkBlueColor
        case "happiness":
            return Styling.Colors.yellowColor
        case "neutral":
            return Styling.Colors.pinkColor
        case "sadness":
            return Styling.Colors.darkPurpleColor
        case "surprise":
            return Styling.Colors.purpleColor
        default:
            break
        }
        return UIColor.white
    }

    
    //MARK: Cell Selection
    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState, selectedDate: Date) {
        if delegate != nil {
            delegate!.dateWasClicked(view: view, cellState: cellState, selectedDate: selectedDate)
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState, selectedDate: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState, selectedDate: date)
    }
    
    
    //MARK: Month Header
    func calendar(_ calendar: JTAppleCalendarView, sectionHeaderSizeFor range: (start: Date, end: Date), belongingTo month: Int) -> CGSize {
        return CGSize(width: 200, height: 50)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplaySectionHeader header: JTAppleHeaderView, range: (start: Date, end: Date), identifier: String) {
        let headerCell = (header as? MonthHeaderView)
        let calendar = Calendar.current
        let month = myDateFormatter.formatMonth(month: calendar.component(.month, from: range.start))
        let year = calendar.component(.year, from: range.start)
        headerCell?.monthLabel.text = "\(month) \(year)"
        headerCell?.backgroundColor = Styling.Colors.buttons
        
    }

}
