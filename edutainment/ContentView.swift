//
//  ContentView.swift
//  edutainment
//
//  Created by Luke Inger on 03/08/2021.
//

import SwiftUI

struct ContentView: View {
    
    struct Question {
        var question: String
        var answer: Int
        
        init(question: String, answer: Int){
            self.question = question
            self.answer = answer
        }
    }
    
    @State private var maxValue :Int = 2
    @State private var numOfQuestions :Int = 0
    @State private var questions:[Question] = []
    
    var body: some View {
        Form{
            VStack{
                HStack{
                    Stepper("Multiplication tables", value:$maxValue, in: 2...12)
                        .labelsHidden()
                    Text("\(maxValue) X Times tables")
                }
                Picker(selection: $numOfQuestions, label: Text("Number of questions"), content: {
                    Text("5").tag(5)
                    Text("10").tag(10)
                    Text("20").tag(20)
                    Text("All").tag(0)
                })
                .pickerStyle(SegmentedPickerStyle())
                
            }
        }
    }
    
    func generateQuestions(){
        //Reset the questions array
        self.questions.removeAll()
        
        for _ in 0...numOfQuestions {
            
            let input:Int = Int.random(in: 2...maxValue)
            let input2 :Int = Int.random(in: 2...12)
            
            self.questions.append(Question(question: "\(input) X \(input2)", answer: input * input2))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
