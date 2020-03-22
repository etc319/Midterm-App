//
//  ContentView.swift
//  Midterm Data Model
//
//  Created by Elizabeth Chiappini on 3/9/20.
//  Copyright © 2020 lizzychiappini. All rights reserved.
//

import SwiftUI

enum TrashTypes: String, CaseIterable {
    case plasticBag
    case plasticCup
}

struct TrashItem {
    var trashImage: String
    var trashName: TrashTypes
    var dates: [DateComponents] // Date
}

class TrashModel: ObservableObject {
    @Published var trashs = [TrashItem]()
    
    init() {
        let plasticBag = TrashItem(trashImage: TrashTypes.plasticBag.rawValue,
                                   trashName: TrashTypes.plasticBag,
                                   dates: [DateComponents]())
        trashs.append(plasticBag)
        
        let plasticCup = TrashItem (trashImage: TrashTypes.plasticCup.rawValue,
                                    trashName: TrashTypes.plasticCup,
                                    dates: [DateComponents]())
        
        trashs.append(plasticCup)
    }
    
    func addDate(index: Int) {
        let now = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        trashs[index].dates.append(now)
        
        let count = trashs[index].dates.count
        print("dates:", trashs[index].dates)
    }
    
    func getCount(index: Int) -> Int {
        return trashs[index].dates.count
    }
    
    func getDayCount(index: Int) -> Int {
        let trashItem = trashs[index]
        let currentDate = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        
        var dayCount = 0
        
        for date in trashItem.dates {
            if (currentDate == date) {
                dayCount+=1
            }
        }
        
        print("dayCount:", dayCount)
        return dayCount
    }
}

struct ContentView: View {
    @ObservedObject var trashModel = TrashModel()
    
    var body: some View {
        NavigationView{
            NavigationLink (destination: DetailView()) {
                Text("click here")
            }
        HStack{
            Button(action: {
                self.trashModel.addDate(index: 0)
                self.trashModel.getDayCount(index: 0)
            }) {
                VStack {
                    Image(self.trashModel.trashs[0].trashImage)
                        .resizable()
                        .frame(width: 100, height: 100)
        Text(self.trashModel.trashs[0].trashName.rawValue)
                    Text("\(self.trashModel.getCount(index: 0))")
                }
            }
        }
            .buttonStyle(PlainButtonStyle())
                
            
            
            Button(action: {
                self.trashModel.addDate(index: 1)
            }) {
                VStack {
                    //                Text("Add plastic cup")
                    Image(self.trashModel.trashs[1].trashImage)
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text(self.trashModel.trashs[1].trashName.rawValue)
                    Text("\(self.trashModel.getCount(index: 1))")
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
