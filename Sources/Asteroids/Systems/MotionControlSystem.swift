//
//  MotionControlSystem.swift
//  FirebladeECSDemo
//
//  Created by Igor Kravchenko on 21.11.2020.
//

import FirebladeECS
import FirebladeMath
import Foundation
import AsteroidsGameLibrary

let twoPi = Double.pi * 2

extension Double {
    var degrees : Double {
        (self * 180) / .pi
    }

    var positiveRadians : Double {
        self > 0 ? self : Foundation.fmod(self + twoPi, twoPi)
    }
}

extension Vector {
    var angle : Double {
        Foundation.atan2(self.y, self.x)
    }
}

func same(_ x : Double,  _ y : Double) -> Bool {
    x == y || x == nextafter(y, .greatestFiniteMagnitude) || x == nextafter(y, -.greatestFiniteMagnitude)
}

func same(_ v1 : Vector, _ v2 : Vector) -> Bool {
    same(v1.x, v2.x) && same(v1.y, v2.y)
}

func lerpPrecise(_ v1 : Vector, _ v2 : Vector, _ t : Double) -> Vector {
    Vector(x: lerpPrecise(v1.x, v2.x, t), y: lerpPrecise(v1.y, v2.y, t))
}

final class MotionControlSystem<InputType: Hashable> {
    private let anyInputActive: (Set<InputType>) -> Bool
    private let joystickAxes : () -> (Vector?, Vector?)
    private let motionControls: Family3<MotionControls<InputType>, Position, Motion>
    private var joystickDirection : Vector?

    init(anyInputActive: @escaping (Set<InputType>) -> Bool, joystickAxes : @escaping () -> (Vector?, Vector?), nexus: Nexus) {
        self.anyInputActive = anyInputActive
        self.joystickAxes = joystickAxes
        motionControls = nexus.family(requiresAll: MotionControls.self, Position.self, Motion.self)
    }

    func update(time: Double) {
        // compute the angle of the joystick input, if any.
        let (left, _) = joystickAxes()
        joystickDirection = left?.normalized
        let targetDirection = joystickDirection
        var stillRotating = false
        for (control, position, motion) in motionControls {
            if let targetDirection = targetDirection {
                let rotation = position.rotation
                let currentDirection = Vector(x: cos(rotation), y: sin(rotation))
                let newDirection = lerpPrecise(currentDirection, targetDirection, 0.1)
                if (!same(newDirection, targetDirection)) {
                    stillRotating = true
                }
                position.rotation = newDirection.angle
            } else {
                if anyInputActive(control.left) {
                    position.rotation -= control.rotationRate * time
                }

                if anyInputActive(control.right) {
                    position.rotation += control.rotationRate * time
                }
            }

            if anyInputActive(control.accelerate) {
                motion.velocity.x += cos(position.rotation) * control.accelerationRate * time
                motion.velocity.y += sin(position.rotation) * control.accelerationRate * time
            }

            if anyInputActive(control.decelerate) {
                motion.velocity.x -= cos(position.rotation) * control.accelerationRate * time
                motion.velocity.y -= sin(position.rotation) * control.accelerationRate * time
            }
        }

        if !stillRotating {
            joystickDirection = nil
        }
    }
}
