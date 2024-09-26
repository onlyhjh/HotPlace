//
//  OneTimePassword.swift
//  gma_common
//
//  Created by 60192229 on 10/27/23.
//

import SwiftUI

public
struct OneTimePassword: View {
    
    public init(currentSec: Int, timeoutSec: Int = 60, password: String) {
        self.currentSec = currentSec
        self.timeoutSec = timeoutSec
        self.password = password
    }
    
    /// current progressing time
    var currentSec:Int
    /// timeout max time
    var timeoutSec:Int = 60
    /// otp password
    var password: String
    private let title = "One Time Password"
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray200)
                .frame(width: 243, height: 98)

            HStack {
                ZStack {
                   ProgressTrack(counter: currentSec, countTo: timeoutSec)
                
                    Text("\(timeoutSec - currentSec)")
                        .typography(.heading2, weight: .heavy, color: Color.blue500)
                        .frame(width:48, height:48)
                }
                .frame(width: 48, height: 48)
                Spacer()
                    .frame(width: 16)
                VStack {
                    Text(title)
                        .typography(14, weight: .bold, color: .gray600)
                        .frame(width: 139, height: 21)
                        .padding(.bottom, 4)
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray500)
                            .frame(width: 139, height: 37)
                        Text(password)
                            .tracking(2.5) //TODO: - check guide spaces
                            .typography(18, weight: .heavy, color: .white)
                            .frame(width: 139)
                    }
                }
            }
            .frame(width:203, height: 66)
        }
    }
}

// MARK: - sub components
fileprivate
struct ProgressTrack: View {
    
    var counter: Int
    var countTo: Int
    var trackColor: Color = Color.gray300
    var progressColor: Color = Color.blue500
    var lineWidth: CGFloat = 4.0
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.clear)
                .overlay (
                    Circle().stroke(trackColor, lineWidth: lineWidth)
                )
            Circle()
                .trim(from:0, to: progress())
                .stroke (
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
                )
                .foregroundColor( completed() ? progressColor : progressColor)
                .rotationEffect(.degrees(-90))
                
        }
    }
    
    func progress()->CGFloat {
        return (CGFloat(counter) / CGFloat(countTo))
    }
    
    func completed()->Bool {
        return progress() == 1
    }
}


// MARK: - Preview
// MARK: OneTimePassword
struct OneTimePasswordComponent_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue
            VStack {
                OneTimePassword(currentSec: 1, timeoutSec: 60, password: "023456")
            }
        }
    }
}
    
// MARK: Progress
struct Progress_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue
            VStack {
                ProgressTrack(counter: 1, countTo: 60)
                    .frame(width: 44, height: 44)
                ProgressTrack(counter: 30, countTo: 60)
                    .frame(width: 44, height: 44)
                ProgressTrack(counter: 60, countTo: 60)
                    .frame(width: 44, height: 44)
            }
        }
    }
}
