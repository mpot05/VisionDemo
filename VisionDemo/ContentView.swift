//
//  ContentView.swift
//  VisionDemo
//
//  Created by Michael Potter on 4/2/24.
//

import SwiftUI
import RealityKit
import RealityKitContent
import ARKit

struct ContentView: View {

    @State var box = ModelEntity()
    @State var floor = ModelEntity()
    @State var wall1 = ModelEntity()
    @State var wall2 = ModelEntity()
    @State var wall3 = ModelEntity()
    @State var wall4 = ModelEntity()

    let session = ARKitSession()
    let planeData = PlaneDetectionProvider(alignments: [.horizontal, .vertical])

    @State var Floaty: Entity = {
        let headAnchor = AnchorEntity(.head)
        headAnchor.position = [0.7, -0.35, -1]
        return headAnchor
    }()
    
    var planeEntity: Entity {
        let wallAnchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: SIMD2<Float>(0.6,0.6)))
        let planeMesh = MeshResource.generatePlane(width:3.75, depth: 2.65, cornerRadius: 0.1)
        let material = SimpleMaterial(color: .brown, isMetallic: true)
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
        let planeBody = ShapeResource.generateBox(width: 1, height: 1, depth: 1)
        wallAnchor.components.set(PhysicsBodyComponent(shapes: [planeBody], mass: 0))
        wallAnchor.generateCollisionShapes(recursive: false)
        planeEntity.name = "canvas"
        wallAnchor.addChild(planeEntity)
        return wallAnchor
    }
    
    var planeEntity2: Entity {
        let floorAnchor = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: SIMD2<Float>(0.6,0.6)))
        let planeMesh = MeshResource.generatePlane(width:3.75, depth: 2.65, cornerRadius: 0.1)
        let material = SimpleMaterial(color: .brown, isMetallic: true)
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
        planeEntity.name = "canvas"
        let planeBody = ShapeResource.generateBox(width: 1, height: 1, depth: 1)
        floorAnchor.components.set(PhysicsBodyComponent(shapes: [planeBody], mass: 0))
        floorAnchor.generateCollisionShapes(recursive: false)
        floorAnchor.addChild(planeEntity)
        return floorAnchor
    }

    var body: some View {
        VStack {
            
            RealityView { content in
                // Add the initial RealityKit content
                let walloddmesh = MeshResource.generateBox(width: 0.2, height: 5, depth: 5)
                let wallevenmesh = MeshResource.generateBox(width: 5, height: 5, depth: 0.2)
                let wallmat = SimpleMaterial(color: .blue, isMetallic: false)
                let wallres = ShapeResource.generateBox(width: 1, height: 1, depth: 1)
                wall1 = ModelEntity(mesh: walloddmesh, materials: [wallmat])
                wall1.generateCollisionShapes(recursive: false)
                wall1.components.set(GroundingShadowComponent(castsShadow: true))
                wall1.components.set(PhysicsBodyComponent(shapes: [wallres], mass: 0))
                wall2 = ModelEntity(mesh: wallevenmesh, materials: [wallmat])
                wall2.generateCollisionShapes(recursive: false)
                wall2.components.set(GroundingShadowComponent(castsShadow: true))
                wall2.components.set(PhysicsBodyComponent(shapes: [wallres], mass: 0))
                wall3 = ModelEntity(mesh: walloddmesh, materials: [wallmat])
                wall3.generateCollisionShapes(recursive: false)
                wall3.components.set(GroundingShadowComponent(castsShadow: true))
                wall3.components.set(PhysicsBodyComponent(shapes: [wallres], mass: 0))
                wall4 = ModelEntity(mesh: wallevenmesh, materials: [wallmat])
                wall4.generateCollisionShapes(recursive: false)
                wall4.components.set(GroundingShadowComponent(castsShadow: true))
                wall4.components.set(PhysicsBodyComponent(shapes: [wallres], mass: 0))
                wall1.position = SIMD3(x: 2.5, y: 2.5, z: 0)
                wall2.position = SIMD3(x: 0, y: 2.5, z: 2.5)
                wall3.position = SIMD3(x: -2.5, y: 2.5, z: 0)
                wall4.position = SIMD3(x: 0, y: 2.5, z: -2.5)
                
                
                let floormesh = MeshResource.generateBox(width: 5, height: 0.1, depth: 5)
                let flomaterial = loadImageMaterial(imageUrl: "Haverford_H")
                floor = ModelEntity(mesh: floormesh, materials: [flomaterial])
                floor.generateCollisionShapes(recursive: false)
                floor.components.set(GroundingShadowComponent(castsShadow: true))
                let flores = ShapeResource.generateBox(width: 1, height: 1, depth: 1)
                floor.components.set(PhysicsBodyComponent(shapes: [flores], mass: 0))

                let boxmesh = MeshResource.generateBox(size: 1)
                let material = SimpleMaterial(color: .red, isMetallic: true)
                box = ModelEntity(mesh: boxmesh, materials: [material])
                box.components.set(InputTargetComponent(allowedInputTypes: .indirect))
                box.generateCollisionShapes(recursive: false)
                box.components.set(GroundingShadowComponent(castsShadow: true))
                let shapere = ShapeResource.generateBox(width: 0.3, height: 0.3, depth: 0.3)
                box.components.set(PhysicsBodyComponent(shapes: [shapere], mass: 1))
                box.position = SIMD3(x: 0, y: 1, z: 0)
                box.physicsBody?.isContinuousCollisionDetectionEnabled = true
                box.physicsBody?.mode = .dynamic
                if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                    Floaty.addChild(box)
                    content.add(box)
                    content.add(floor)
                    content.add(wall1)
                    content.add(wall2)
                    content.add(wall3)
                    content.add(wall4)
                    content.add(planeEntity)
                    content.add(planeEntity2)
                }
                
            } update: { content in
                var planeEntity2: Entity {
                    let floorAnchor = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: SIMD2<Float>(0.6,0.6)))
                    let planeMesh = MeshResource.generatePlane(width:3.75, depth: 2.65, cornerRadius: 0.1)
                    let material = SimpleMaterial(color: .brown, isMetallic: true)
                    let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
                    planeEntity.name = "canvas"
                    let planeBody = ShapeResource.generateBox(width: 1, height: 1, depth: 1)
                    floorAnchor.components.set(PhysicsBodyComponent(shapes: [planeBody], mass: 0))
                    floorAnchor.generateCollisionShapes(recursive: false)
                    floorAnchor.addChild(planeEntity)
                    return floorAnchor
                }
                content.remove(planeEntity2)
                planeEntity2.removeFromParent()
                content.add(planeEntity2)
                
            }
            .gesture(
                DragGesture()
                .targetedToEntity(box)
                .onChanged({ value in
                    box.position = value.convert(value.location3D, from: .local, to: box.parent!)
                    box.clearForcesAndTorques()
                    box.physicsMotion?.angularVelocity = SIMD3(x: 0, y: 0, z: 0)
                    box.physicsMotion?.linearVelocity = SIMD3(x: 0, y: 0, z: 0)
                    
                })
            )
        }
    }
    func loadImageMaterial(imageUrl: String) -> SimpleMaterial {
        do {
            let texture = try TextureResource.load(named: imageUrl)
            var material = SimpleMaterial()
            let color = SimpleMaterial.BaseColor(texture: MaterialParameters.Texture(texture))
            material.color = color
            return material
        } catch {
            fatalError(String(describing: error))
        }
    }
    
}

