//
//  TextFieldTimer.swift
//  gma_common
//
//  Created by 60080254 on 2022/10/27.
//
import Foundation

public class TextFieldTimer: ObservableObject {
	static var timerObject : Timer?
	@Published public var remainingTime: Int = 0
	public var remainingTimeString: String {
		get {
			return String(format: "%02d:%02d", remainingTime / 60, remainingTime % 60)
		}
	}
	
	let timerEndAction: ()->()
	
	public func timerStop() {
		TextFieldTimer.timerObject?.invalidate()
	}
	
	public func timerStart() {
		timerStop()
		TextFieldTimer.timerObject = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
			if self.remainingTime > 0 {
				self.remainingTime -= 1
				
				if self.remainingTime <= 0 {
					self.timerStop()
					self.timerEndAction()
				}
			}
		}
	}
	
	public func timerStart(_ remainingTime: Int) {
		self.remainingTime = remainingTime
		timerStart()
	}
	
	public init(_ remainingTime: Int = 0, timerEndAction: @escaping ()->() = {}) {
		self.remainingTime = remainingTime
		self.timerEndAction = timerEndAction
		if self.remainingTime > 0 {
			timerStart()
		}
	}
}
