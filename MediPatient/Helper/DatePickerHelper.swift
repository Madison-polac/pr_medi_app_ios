//
//  DatePickerHelper.swift
//  MediPatient
//
//  Created by Nick Joliya on 24/08/25.
//

import UIKit

class DatePickerHelper {
    static func show(in parentVC: UIViewController,
                     title: String = "Select Date",
                     mode: UIDatePicker.Mode = .date,
                     maximumDate: Date? = nil,
                     minimumDate: Date? = nil,
                     initialDate: Date? = nil,
                     onPicked: @escaping (Date) -> Void) {
        
        let alert = UIAlertController(title: title, message: "\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = mode
        datePicker.maximumDate = maximumDate
        datePicker.minimumDate = minimumDate
        datePicker.date = initialDate ?? Date()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame = CGRect(x: 0, y: 40, width: alert.view.bounds.width-20, height: 180)
        alert.view.addSubview(datePicker)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { _ in
            onPicked(datePicker.date)
        }))
        
        parentVC.present(alert, animated: true, completion: nil)
    }
}

