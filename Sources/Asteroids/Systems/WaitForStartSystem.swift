//
//  WaitForStartSystem.swift
//  FirebladeECSDemo
//
//  Created by Igor Kravchenko on 21.11.2020.
//

import FirebladeECS

final class WaitForStartSystem<InputType : Hashable> {
    private let anyInputActive: (Set<InputType>) -> Bool
    private let creator: EntityCreator
    private let config: GameConfig
    private let games: Family1<GameState>
    private let waits: Family1<WaitForStart<InputType>>
    private let asteroids: Family1<Asteroid>

    init(anyInputActive: @escaping (Set<InputType>) -> Bool, creator: EntityCreator, nexus: Nexus, config: GameConfig) {
        self.anyInputActive = anyInputActive
        self.creator = creator
        self.config = config
        waits = nexus.family(requires: WaitForStart<InputType>.self)
        games = nexus.family(requires: GameState.self)
        asteroids = nexus.family(requires: Asteroid.self)
    }

    func update() {
        for (waitEntity, waitForStart) in waits.entityAndComponents where anyInputActive(waitForStart.startTrigger) {
            for game in games {
                for (asteroidEntity, _) in asteroids.entityAndComponents {
                    creator.destroy(entity: asteroidEntity)
                }
                game.setForStart()
                creator.destroy(entity: waitEntity)
            }
        }
    }
}
