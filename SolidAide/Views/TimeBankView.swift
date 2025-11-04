
/*


   ____     ___    ___  ___   _    __
  / __/__  / (_)__/ ( )/ _ | (_)__/ /__
 _\ \/ _ \/ / / _  /|// __ |/ / _  / -_)
/___/\___/_/_/\_,_/  /_/ |_/_/\_,_/\__/
                                      




  O          o
 / \         |
o---oo-o   o-O o-o o-o o  o
|   ||  | |  | |   |-' |  |
o   oo  o  o-o o   o-o o--O
                          |
                       o--o
o--o    o   o
|       | o |
O-o   o-O   | o-o o-o  o-o
|    |  | | | |-' |  | |-'
o--o  o-o | o o-o o  o o-o


o--o o
|    |         o
O-o  | o-o o-o    oo o-o
|    | | | |   | | | |  |
o    o o-o o   | o-o-o  o


 o-o
|                   o
 o-o  o   o o-o o-o   o-o  o-o
    |  \ /  |-' |   | |  | |-'
o--o    o   o-o o   | o  o o-o

 o-o   o
|      |
 o-o  -o-  oo  o-o o  o
    |  |  | | |    |  |
o--o   o  o-o- o-o o--O
                      |
                   o--o




   __
  / ()  ,_   _  _, _|_  _  _|     |)           ()_|_  _,   _
 |     /  | |/ / |  |  |/ / |     |/\_|  |     /\ |  / |  /   |  |
  \___/   |/|_/\/|_/|_/|_/\/|_/    \/  \/|/   /(_)|_/\/|_/\__/ \/|/
                                        (|                      (|
 


*/


import SwiftUI
import Charts
import SwiftData

struct TimeBankView: View {

    
    @Environment(\.modelContext) private var context
    @Query var users: [UserClass]
    @Query var profiles: [ProfileClass]
    @Query var chats: [ChatClass]
    @Query var services: [ServiceClass]
    @Query var timeBanks: [TimeBankClass]
    @AppStorage("selectedFont") private var selectedFontRaw = AppFont.system.rawValue
    
/*
  _____ _                _   _____        _
 / ____| |              | | |  __ \      | |
| |    | |__   __ _ _ __| |_| |  | | __ _| |_ __ _
| |    | '_ \ / _` | '__| __| |  | |/ _` | __/ _` |
| |____| | | | (_| | |  | |_| |__| | (_| | || (_| |
 \_____|_| |_|\__,_|_|   \__|_____/ \__,_|\__\__,_|
 */
    @State public var timeValues: [Int] = [
        3, 2, 5, 7, 6, 5, 4, 3, 5, 7, 6, 5, 4, 3, 5
    ]
   
    /*
     ____            _
    |  _ \          | |
    | |_) | ___   __| |_   _
    |  _ < / _ \ / _` | | | |
    | |_) | (_) | (_| | |_| |
    |____/ \___/ \__,_|\__, |
                        __/ |
                       |___/ 
     */
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
                HStack{
                    NavigationLink {
                        HistoricalTimeView()
                    } label: {
                        ZStack{
                            Rectangle()
                                .fill(Color("deepBlue"))
                                .cornerRadius(15)
                                .frame(height: 30)
                            HStack{
                                Image(systemName: "hourglass.badge.eye")
                                    .foregroundStyle(Color.white)
                                Text("Historique")
                                    .foregroundStyle(Color.white)
                                    .applyAppFont(18)
                            }
                            .padding(.horizontal, 12)
                        }
                    }
                    NavigationLink {
                        SettingsView()
                    } label: {
                        ZStack{
                            Rectangle()
                                .fill(Color("deepBlue"))
                                .cornerRadius(15)
                                .frame(height: 30)
                            HStack{
                                Image(systemName: "gearshape.fill")
                                    .foregroundStyle(Color.white)
                                Text("Paramètres")
                                    .foregroundStyle(Color.white)
                                    .applyAppFont(18)
                               }
                            .padding(.horizontal, 12)
                            }
                        }
                }
                
/*
  _____ _         _     _
 / ____| |       | |   | |
| (___ | |_ _   _| |__ | |__   ___  _ __ _ __
 \___ \| __| | | | '_ \| '_ \ / _ \| '__| '_ \
 ____) | |_| |_| | |_) | |_) | (_) | |  | | | |
|_____/ \__|\__,_|_.__/|_.__/ \___/|_|  |_| |_|
                                             
 */
                ZStack {
                    Rectangle()
                        .frame(width: 300, height: 50)
                        .foregroundColor(Color("mintGreen"))
                    Text("Banque du Temps")
                        .foregroundStyle(.white)
                        .applyAppFont(18)
                }
                .padding()
/*
  _____ _                _
 / ____| |              | |
| |    | |__   __ _ _ __| |_
| |    | '_ \ / _` | '__| __|
| |____| | | | (_| | |  | |_
 \_____|_| |_|\__,_|_|   \__|
                            
 */
                Chart {
                    ForEach(Array(timeValues.enumerated()), id: \.offset) { index, value in
                        LineMark(
                            x: .value("Index", index),
                            y: .value("Valeur", value)
                        )
                        .foregroundStyle(Color("goldenYellow"))
                        
                        PointMark(
                            x: .value("Index", index),
                            y: .value("Valeur", value)
                        )
                        .foregroundStyle(Color("goldenYellow"))
                        .symbolSize(30)
                    }
                }
                .chartXAxis(.hidden)
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .frame(width: 327, height: 100)
                .background(Color("deepBlue"))
                .padding(.top, 8)
/*
  _____                _ _ _      _     _
 / ____|              | | | |    (_)   | |
| (___   ___ _ __ ___ | | | |     _ ___| |_
 \___ \ / __| '__/ _ \| | | |    | / __| __|
 ____) | (__| | | (_) | | | |____| \__ \ |_
|_____/ \___|_|  \___/|_|_|______|_|___/\__|
                                           
 */
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {

                        ForEach(timeBanks.sorted { $0.date < $1.date }) { entry in
                            VStack(alignment: .leading, spacing: 6) {
                                HStack(alignment: .top, spacing: 8) {
                                    Image(systemName: entry.iconName)
                                        .foregroundColor(entry.swiftUIColor)
                                        .font(.title2)
                                    VStack(alignment: .leading, spacing: 1) {
                                        Text(entry.date, style: .date)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                        Text(entry.date, style: .time)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Text(entry.title)
                                            .font(.body)
                                            .foregroundColor(.primary)
                                        Text(entry.subtitle)
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(.systemBackground).opacity(0.6))
                                )
                            }
                            .padding(.horizontal, 4)
                            .padding(.vertical, 6)
                            
                            if entry.id != timeBanks.last?.id {
                                Divider()
                                    .padding(.horizontal, 12)
                            }
                        }
                    }
                    .padding(.vertical, 12)
                }
                .applyAppFont(18)
                .frame(minWidth: 327)
                .background(Color(.secondarySystemBackground).opacity(0.3))
                .cornerRadius(12)
                .padding(.horizontal, 16)
                Spacer()
            }
            .background(Color("deepBlue").opacity(0.05))
        }
    }

   
    private func popFirstAndAppend(_ newValue: Int) {
        if !timeValues.isEmpty {
            timeValues.removeFirst()
        }
        timeValues.append(newValue)
    }
}


struct TimeBankView_Previews: PreviewProvider {
    static var previews: some View {
        TimeBankView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
