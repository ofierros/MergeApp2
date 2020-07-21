//
//  RecordTableViewController.swift
//  HeartAI
//
//  Created by Cody Smith on 6/23/20.
//  Copyright © 2020 Algorrhythmics. All rights reserved.
//

import UIKit


class RecordTableViewController: UITableViewController {
    
    
    //MARK: Properties
    
    var sampEvents = Array<EventRecord?>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadSampleEvents()
        
        // Bits 23-20 represent months 0-12
        // Bits 19-15 represent days of the month from 1-31
        // Bits 14-4 represent minutes of the day from 0 (midnight) to 11:59pm (23:59)
        // Bits 3-0 used for number of years since 2020
        
        //
        //            Arrhythmia 0,   month 5,     day 22,      time 12:42, year 2020
 /*       let example0 = 0x00000000 | ( (0x5<<20) | (0x16<<15) | (0x2FA<<4) | (0x0) )
        loadEvent(newEvent: receiveData(fromBT: example0))
        
        
        //            Arrhythmia 1,   month 6,     day 30,      time 18:04, year 2020
        let example1 = 0x01000000 | ( (0x6<<20) | (0x1E<<15) | (0x43C<<4) | (0x0) )
        loadEvent(newEvent: receiveData(fromBT: example1))
        
        
        //            Arrhythmia 2,   month 7,     day 6,       time 08:55, year 2020
        let example2 = 0x02000000 | ( (0x7<<20) | (0x06<<15) | (0x217<<4) | (0x0) )
        loadEvent(newEvent: receiveData(fromBT: example2))
        
        
        //            Arrhythmia 3,   month 10,    day 31,      time 21:13, year 2020
        let example3 = 0x03000000 | ( (0xA<<20) | (0x1F<<15) | (0x4F9<<4) | (0x0) )
        loadEvent(newEvent: receiveData(fromBT: example3))
        
        
        //            Arrhythmia 4,   month 1,     day 1,       time 00:01, year 2021
        let example4 = 0x04000000 | ( (0x1<<20) | (0x01<<15) | (0x001<<4) | (0x1) )
        loadEvent(newEvent: receiveData(fromBT: example4))

  */
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampEvents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CellPrototype"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HistoryCellTableViewCell
        else {
            fatalError("The dequeued cell is not an instance of HistoryCellTableViewCell")
        }
            
        let event = self.sampEvents[indexPath.row]
        cell.nameLabel.text = event?.name
        cell.dateLabel.text = event?.date
        cell.timeLabel.text = event?.time
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }*/
    
    
    //MARK: Private Methods
    
    private func loadSampleEvents() {
        let arrh1 = EventRecord(name: "Tachycardia", date:"06-20-2020", time: "01:00" )
        let arrh2 = EventRecord(name: "Atrial Fibrillation", date:"06-23-2020", time: "12:36" )
        let arrh3 = EventRecord(name: "Bradycardia", date:"06-26-2020", time: "09:08" )
        let arrh4 = EventRecord(name: "Pause", date:"07-01-2020", time: "17:30" )
        sampEvents += [arrh1, arrh2, arrh3, arrh4]
    }
    func loadEvent(newEvent: EventRecord){
        self.sampEvents.insert(newEvent, at: 0)
    }
    
    func receiveData(fromBT: Int) -> EventRecord{
        //First parse out the type of arrhythmia, example using 5 bits = 2^4 = 16 possibilities. For example purposes, we will consider 5 options
        // Bits 27-24 represent the type of arrhythmia
        var typeArrh: Int = fromBT & (0x0F000000)
        var newName = ""
        var newDate = ""
        var newTime = ""
        
        typeArrh = typeArrh>>24
        switch(typeArrh){
        case 0: newName = "Atrial Fibrillation"
            break
        case 1: newName = "Atrial tachycardia"
            break
        case 2: newName = "Ventricular fibrillation"
            break
        case 3: newName = "Ventricular tachycardia"
            break
        case 4: newName = "Heart block"
            break
        default: newName = "Outside of demonstration"
            break
        }
        // Bits 23-20 represent months 0-12
        var month = (fromBT & 0x00F00000)
        month = month>>20
        // Bits 19-15 represent days of the month from 1-31
        var day = (fromBT & 0x000F8000)
        day = day>>15
        // Bits 14-4 represent minutes of the day from 0 (midnight) to 11:59pm (23:59)
        var mins = (fromBT & 0x00007FF0)
        mins = mins>>4
        // Bits 3-0 used for number of years since 2020
        let year = (2020 + (fromBT & 0x0000000F) )
        // Bits 31-28 unused for now
        
        //Logic to parse out months
        if ((month > 12) || day > 31) {
           newDate = "Invalid date"
        }
        else if ((month >= 10) && (day >= 10)){
            newDate = "\(month)-\(day)-\(year)"
        }
        else if((month < 10) && (day < 10)){
            newDate = "0\(month)-0\(day)-\(year)"
        }
        else if((month >= 10) && (day < 10)){
            newDate = "\(month)-0\(day)-\(year)"
        }
        else if((month < 10) && (day >= 10)){
            newDate = "0\(month)-\(day)-\(year)"
        }
        else{
            newDate = "Invalid Date"
        }
        // Logic to parse out hours and minutes
        if(mins > 1440){
           newTime = "Invalid time"
        }
        else if((mins/60 >= 10) && (mins%60 >= 10)){
            newTime = "\(mins/60):\(mins%60)"
        }
        else if((mins/60 < 10) && (mins%60 >= 10)){
            newTime = "0\(mins/60):\(mins%60)"
        }
        else if((mins/60 >= 10) && (mins%60 < 10)){
            newTime = "\(mins/60):0\(mins%60)"
        }
        else if((mins/60 < 10) && (mins%60 < 10)){
            newTime = "0\(mins/60):0\(mins%60)"
        }
        else{
            newTime = "Invalid Time"
        }
        
        return EventRecord(name: newName, date: newDate, time: newTime)!
        
    }
    
    

}
