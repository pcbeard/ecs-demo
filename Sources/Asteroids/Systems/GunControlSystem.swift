//
//  GunControlSystem.swift
//  FirebladeECSDemo
//
//  Created by Igor Kravchenko on 21.11.2020.
//

import FirebladeECS

final class GunControlSystem<InputType: Hashable> {
    private let anyInputActive: (Set<InputType>) -> Bool
    private let creator: EntityCreator
    private let gunControllsFamily: Family4<Gun, GunControls<InputType>, Position, Audio>

    init(anyInputActive: @escaping (Set<InputType>) -> Bool, creator: EntityCreator, nexus: Nexus) {
        self.anyInputActive = anyInputActive
        self.creator = creator
        gunControllsFamily = nexus.family(requiresAll: Gun.self, GunControls.self, Position.self, Audio.self)
    }

    func update(time: Double) {
        for (gun, controls, position, audio) in gunControllsFamily {
            gun.shooting = anyInputActive(controls.trigger)
            gun.timeSinceLastShot += time
            if gun.shooting && gun.timeSinceLastShot >= gun.minimumShotInterval {
                creator.createBullet(gun: gun, parentPosition: position)
                audio.play(sound: .shootGun)
                gun.timeSinceLastShot = 0
            }
        }
    }
}
