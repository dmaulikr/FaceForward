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
    
    //MARK: All the Cells in a Month
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        
        let myCustomCell = cell as! CellView
        
        //Current Date Color
        dateFormatter.dateFormat = "yyy MM dd"
        let currentDateString = dateFormatter.string(from: Date())
        let cellStateDateString = dateFormatter.string(from: cellState.date)
        
        if  currentDateString ==  cellStateDateString {
            markCurrentDate(cell: myCustomCell)
        } else {
            myCustomCell.currentColor.isHidden = true
        }
        
        //Mood Colors
        for moodDate in moodData!{
            let startOfDay = Calendar.current.startOfDay(for: moodDate.date)
            if startOfDay == cellState.date {
                let emotionToday = moodDate.emotion[0].largestEmotion
                let color = setCalendarCellColor(colorMood: emotionToday)
                myCustomCell.moodColor.backgroundColor = color
                myCustomCell.moodColor.layer.cornerRadius = myCustomCell.moodColor.layer.frame.width/2
                myCustomCell.moodColor.isHidden = false
                break
            }
            else {
                myCustomCell.moodColor.isHidden = true
            }
        }
        
        //Days To Display
        myCustomCell.dayLabel.text = cellState.text
        
        if cellState.dateBelongsTo == .thisMonth {
            myCustomCell.isHidden = false
        } else {
            myCustomCell.isHidden = true
        }
        handleCellSelection(view: cell, cellState: cellState, selectedDate: cellState.date)
    }
    
    func markCurrentDate(cell: CellView) {
        cell.currentColor.backgroundColor = UIColor.gray
        cell.currentColor.layer.cornerRadius = cell.currentColor.layer.frame.size.width/2
        cell.currentColor.isHidden = false
    }
    
    func setCalendarCellColor(colorMood: String) -> UIColor {
        switch colorMood {
        case "anger":
            return UIColor.red
        case "contempt":
            return UIColor.yellow
        case "disgust":
            return UIColor.cyan
        case "fear":
            return UIColor.green
        case "happiness":
            return UIColor.cyan
        case "neutral":
            return UIColor.purple
        case "sadness":
            return UIColor.black
        case "surprise":
            return UIColor.brown
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
        
    }
    
    
    
   
    
}