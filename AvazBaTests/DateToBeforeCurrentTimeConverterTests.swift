//
//  DateToBeforeCurrentTimeConverterTests.swift
//  AvazBaTests
//
//  Created by Valentin Šarić on 05/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import Cuckoo
import Quick
import Nimble
@testable import AvazBa

class DateToBeforeCurrentTimeConverterTests: QuickSpec {
    
    override func spec() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/dd/MM HH:mm"
        let currentDate = formatter.date(from: "2018/05/12 07:33")
        
        describe("Date to proper string converter logic"){
            context("Past and current Date is passed in static func"){
                it("have diference of 1 minute"){
                    let dateInPast = formatter.date(from: "2018/05/12 07:32")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 1 min"))
                }
                it("have diference of 2 minutes"){
                    let dateInPast = formatter.date(from: "2018/05/12 07:31")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 2 min"))
                }
                it("have diference of 59 minutes"){
                    let dateInPast = formatter.date(from: "2018/05/12 06:34")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 59 min"))
                }
                it("have diference of 1 hour"){
                    let dateInPast = formatter.date(from: "2018/05/12 06:33")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 1 sat"))
                }
                it("have diference of 2 hours"){
                    let dateInPast = formatter.date(from: "2018/05/12 05:33")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 2 sata"))
                }
                it("have diference of 5 hours"){
                    let dateInPast = formatter.date(from: "2018/05/12 02:33")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 5 sati"))
                }
                it("have diference of 13 hours"){
                    let dateInPast = formatter.date(from: "2018/04/12 18:33")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 13 sati"))
                }
                it("have diference of 23 hours"){
                    let dateInPast = formatter.date(from: "2018/04/12 08:33")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 23 sata"))
                }
                it("have diference of 24 hours / 1 day"){
                    let dateInPast = formatter.date(from: "2018/04/12 07:33")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 1 dan"))
                }
                it("have diference of 5 days"){
                    let dateInPast = formatter.date(from: "2018/30/11 07:33")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 5 dana"))
                }
                
                it("have diference of 28 days"){
                    let dateInPast = formatter.date(from: "2018/07/11 07:33")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 28 dana"))
                }
                
                it("have diference of 29 days"){
                    let dateInPast = formatter.date(from: "2018/06/11 07:33")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 29 dana"))
                }
                
                it("have diference of 30 days / Month"){
                    let dateInPast = formatter.date(from: "2018/05/11 07:10")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 1 mjesec"))
                }
                
                it("have diference of 2 months"){
                    let dateInPast = formatter.date(from: "2018/05/09 07:10")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 3 mjeseca"))
                }
                
                it("have diference of 5 months"){
                    let dateInPast = formatter.date(from: "2018/05/06 07:10")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 6 mjeseci"))
                }
                it("have diference of 11 months"){
                    let dateInPast = formatter.date(from: "2017/05/12 07:34")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 11 mjeseci"))
                }
                it("have diference of 12 months / year"){
                    let dateInPast = formatter.date(from: "2017/05/11 07:32")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 1 godine"))
                }
                it("have diference of 30 years"){
                    let dateInPast = formatter.date(from: "1988/4/11 07:32")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 30 godina"))
                }
                it("have diference of 31 years"){
                    let dateInPast = formatter.date(from: "1987/10/11 07:32")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 31 godine"))
                }
                it("have diference of 100 years"){
                    let dateInPast = formatter.date(from: "1918/10/11 07:32")
                    let dateBefore = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: dateInPast!, currentDate: currentDate!)
                    expect(dateBefore).to(equal("Prije 100 godina"))
                }
              
            }
        }
        
    }
    
}
