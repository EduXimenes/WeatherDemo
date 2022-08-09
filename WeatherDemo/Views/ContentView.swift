//
//  ContentView.swift
//  WeatherDemo
//
//  Created by Eduardo Ximenes on 09/08/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    var body: some View {
        VStack{
            
            if let location = locationManager.location {
                if let weather = weather{
                    Text("Weather data fetched!")
                } else{LoadingView()
                        .task{
                            do{
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch{
                                print("Error getting weather: \(error)")
                            }
                        }
                    
                }
            } else {
                if locationManager.isLoading{
                        LoadingView()
                } else{
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.573, saturation: 0.323, brightness: 0.878))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
