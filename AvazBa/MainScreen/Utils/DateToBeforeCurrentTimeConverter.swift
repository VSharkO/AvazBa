//
//  DateToBeforeCurrentTimeConverter.swift
//  AvazBa
//
//  Created by Valentin Šarić on 04/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

class DateToBeforeCurrentTimeConverter{
    
    static func toBeforeCurrentTime(dateInPast : Date, currentDate: Date) -> String{
        var before = ""
        let currentCalendar = Calendar.current
        
        let yearDif = currentCalendar.dateComponents([.year], from: dateInPast, to: currentDate).year
        let monthDif = currentCalendar.dateComponents([.month], from: dateInPast, to: currentDate).month
        let dayDif = currentCalendar.dateComponents([.day], from: dateInPast, to: currentDate).day
        let hourDif = currentCalendar.dateComponents([.hour], from: dateInPast, to: currentDate).hour
        let minutesDif = currentCalendar.dateComponents([.minute], from: dateInPast, to: currentDate).minute
    
        if let years = yearDif, let months = monthDif, let days = dayDif, let hours = hourDif, let minutes = minutesDif{
            if years > 0 && months > 11{
                if years%10 < 5 && years%10 > 0 {
                    before = "Prije \(years) godine"
                }else{
                    before = "Prije \(years) godina"
                }
            }else if months > 0 && days > 29{
                if (months%10>1 && months%10 < 5){
                    before = "Prije \(months) mjeseca"
                }else if months%10==1{
                    before = "Prije \(months) mjesec"
                    if months == 11{
                        before = "Prije \(months) mjeseci"
                    }
                }else{
                    before = "Prije \(months) mjeseci"
                }
            }else if days > 0 && hours > 23{
                if (days%10 == 1){
                    before = "Prije \(days) dan"
                }
                else{
                    before = "Prije \(days) dana"
                }
            }else if hours > 0 && minutes > 59{
                if hours % 10 == 1{
                    before = "Prije \(hours) sat"
                }
                else if hours%10 > 4 {
                    before = "Prije \(hours) sati"
                }else{
                    before = "Prije \(hours) sata"
                    if hours > 9 && hours<21{
                        before = "Prije \(hours) sati"
                    }
                }//minute
            }else if minutes > 0{
                before = "Prije \(minutes) min"
            }else{
                before = "Sada"
            }
        }
        return before
    }
    
}
