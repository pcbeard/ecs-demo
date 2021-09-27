//
//  WaitForStart.swift
//  FirebladeECSDemo
//
//  Created by Igor Kravchenko on 18.11.2020.
//

import FirebladeECS

final class WaitForStart<InputType : Hashable>: Component {
    var startTrigger : Set<InputType>
    var waitForStart: WaitForStartView

    init(startTrigger : Set<InputType>, waitForStart: WaitForStartView) {
        self.startTrigger = startTrigger
        self.waitForStart = waitForStart
    }
}
