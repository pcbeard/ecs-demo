//
//  GunControls.swift
//  FirebladeECSDemo
//
//  Created by Igor Kravchenko on 18.11.2020.
//

import FirebladeECS
import SDL

final class GunControls: ComponentInitializable {
    var trigger: SDL_KeyCode

    init(trigger: SDL_KeyCode) {
        self.trigger = trigger
    }

    required init() {
        trigger = SDLK_UNKNOWN
    }
}
