//
//  GunControlSystem.swift
//  FirebladeECSDemo
//
//  Created by Igor Kravchenko on 21.11.2020.
//

import FirebladeECS

final class GunControlSystem<ControlCode : Hashable> {
    private let isControlActive: (ControlCode) -> Bool
    private let creator: EntityCreator
    private let gunControllsFamily: Family4<Gun, GunControls<ControlCode>, Position, Audio>

    init(isControlActive: @escaping (ControlCode) -> Bool, creator: EntityCreator, nexus: Nexus) {
        self.isControlActive = isControlActive
        self.creator = creator
        gunControllsFamily = nexus.family(requiresAll: Gun.self, GunControls.self, Position.self, Audio.self)
    }

    func update(time: Double) {
        for (gun, controls, position, audio) in gunControllsFamily {
            gun.shooting = controls.triggers.first(where: isControlActive) != nil
            gun.timeSinceLastShot += time
            if gun.shooting && gun.timeSinceLastShot >= gun.minimumShotInterval {
                creator.createBullet(gun: gun, parentPosition: position)
                audio.play(sound: .shootGun)
                gun.timeSinceLastShot = 0
            }
        }
    }
}
