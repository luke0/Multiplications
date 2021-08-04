//
//  ContentView.swift
//  edutainment
//
//  Created by Luke Inger on 03/08/2021.
//

import SwiftUI

struct Question {
    var question: String
    var answer: Int
    
    init(question: String, answer: Int){
        self.question = question
        self.answer = answer
    }
}

struct ContentView: View {
    
    @State private var maxValue :Int = 2
    @State private var numOfQuestions :Int = 0
    @State private var questionToShow: Question?
    @State private var questions:[Question] = []
    @State private var answer:String = ""
    @State private var score:Int = 0

    var body: some View {
        Form{
            VStack{
                Text("Your score is:\(score)")
                Text("Questions left:\(questions.count)")
                HStack{
                    Stepper("Multiplication tables", value:$maxValue, in: 2...12)
                        .labelsHidden()
                    Text("\(maxValue) X Times tables")
                }
                Spacer()
                Text("Number of questions (\(self.numOfQuestions))")
                Picker(selection: $numOfQuestions, label: Text("Number of questions (\(self.numOfQuestions)")){
                    Text("5").tag(5)
                    Text("10").tag(10)
                    Text("20").tag(20)
                    Text("All").tag(0)
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: numOfQuestions, perform: { (value) in
                    generateQuestions()
                })
                Spacer()
                if let value = questionToShow {
                    Text("\(value.question)")
                    TextField("Answer", text:$answer)
                        .onSubmit {
                            if (Int(answer) == value.answer){
                                score += 1
                            }
                            questions.removeLast()
                            self.questionToShow = questions.last
                        }
                }
            }
        }
        .onAppear(){
            generateQuestions()
        }
    }
    
    func generateQuestions(){
        //Reset the questions array
        self.questions.removeAll()
        
        //Set the default value if we have selected ALL
        let maxQuestions = numOfQuestions > 0 ? numOfQuestions : 50
        
        for _ in 1...maxQuestions {
            
            let input:Int = Int.random(in: 2...maxValue)
            let input2 :Int = Int.random(in: 2...12)
            
            self.questions.append(Question(question: "\(input) X \(input2)", answer: input * input2))
        }
        
        print(questions.count)
        self.questionToShow = questions.last
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
