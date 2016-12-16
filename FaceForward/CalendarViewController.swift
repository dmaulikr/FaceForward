//
//  CalendarViewController.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-14.
//
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    // We cache our colors because we do not want to be creating
    // a new color every time a cell is displayed. We do not want a laggy
    // scrolling calendar.
    let notSelectedTextColor = UIColor.black
    let selectedTextColor = UIColor.purple
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.registerCellViewXib(file: "CalendarCell") // Registering your cell is manditory
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        calendarView.scrollEnabled = true
        calendarView.scrollingMode = .stopAtEachCalendarFrameWidth
    }

    //MARK: Selection
    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState) {
        guard let myCustomCell = view as? CellView  else {
            return
        }
        if cellState.isSelected {
            myCustomCell.selectedView.layer.cornerRadius =  25
            myCustomCell.selectedView.isHidden = false
        } else {
            myCustomCell.selectedView.isHidden = true
        }
    }
    
    func handleCellTextColor(view: JTAppleDayCellView?, cellState: CellState) {
        
        guard let myCustomCell = view as? CellView  else {
            return
        }
        
        if cellState.isSelected {
            myCustomCell.dayLabel.textColor = selectedTextColor
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                myCustomCell.dayLabel.textColor = notSelectedTextColor
            } else {
                myCustomCell.dayLabel.textColor = notSelectedTextColor
            }
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }

    
    
}

//MARK: Extension (move later?)
extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate{
        
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM dd yyyy"
        
        let startDate = formatter.date(from: "12 09 2016")!
        let endDate = Date()
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                            numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
                                                calendar: Calendar.current,
                                         generateInDates: .forAllMonths,
                                        generateOutDates: .tillEndOfGrid,
                                          firstDayOfWeek: .sunday)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let myCustomCell = cell as! CellView
        
        myCustomCell.dayLabel.text = cellState.text
        
        if cellState.dateBelongsTo == .thisMonth {
            myCustomCell.dayLabel.textColor = UIColor.black
        } else {
            myCustomCell.dayLabel.textColor = UIColor.lightGray
        }
    }
    
}

