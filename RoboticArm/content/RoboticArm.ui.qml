/****************************************************************************
**
** Copyright (C) 2022 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Design Studio.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQuick
import QtQuick3D

Node {
    id: rootNode
    property int rotation1
    property int rotation2
    property int rotation3
    property int rotation4
    property int rotation5
    property int rotation6
    property int clawsAngle

    
    readonly property alias hand_grab_t_position: hand_grab_t.scenePosition
    readonly property alias hand_position: hand.scenePosition
    readonly property alias arm_position: arm.scenePosition
    readonly property alias armx_position: armx.scenePosition
    readonly property alias hand_hinge_position: hand_hinge.scenePosition
    readonly property alias forearm_position: forearm.scenePosition
    readonly property alias root_position: root.scenePosition

  

    Model {
        id: base
        scale.x: 100
        scale.y: 100
        scale.z: 100
        source: "meshes/base.mesh"
        eulerRotation.x: -90
        materials: [steel_material, plastic_material]

        Model {
            id: root
            y: -5.96047e-08
            z: 1.0472
            eulerRotation.z: rotation1
            source: "meshes/root.mesh"
            materials: [plastic_material, plastic_color_material, steel_material]
            

            Model {
                id: forearm
                x: 5.32907e-15
                y: -0.165542
                z: 1.53472
                eulerRotation.x: rotation2
                source: "meshes/forearm.mesh"
                materials: [plastic_material, steel_material]

                Model {
                    id: arm
                    x: -0
                    y: 0.673
                    z: 2.23425
                    source: "meshes/brazo.mesh"
                    eulerRotation.y: 180
                    eulerRotation.z: -90
                    eulerRotation.x: 90 - rotation3
                    scale.z: 1
                    scale.y: 1
                    scale.x: 1
                    materials: [plastic_material,plastic_color_material2,steel_material,plastic_color_material]

                    Model {
                        id: armx
                        x: 1.58
                        y: 0.005
                        z: 0
                        eulerRotation.x:rotation4
                        scale.z: 0.75
                        scale.y: 0.75
                        scale.x: 0.75
                        source: "meshes/armx.mesh"
                        materials: [plastic_material, plastic_qt_material, steel_material]

                        Model {
                            id: hand_hinge
                            x: 1.001
                            y: -0
                            z: 0
                            eulerRotation.x: 0
                            source: "meshes/hand_hinge.mesh"
                            eulerRotation.z: 90
                            eulerRotation.y: rotation5 + 90
                            materials: [plastic_material]

                            Model {
                                id: hand
                                x: 3.35649e-06
                                y: 2.38419e-07
                                z: 0.366503
                                eulerRotation.z:rotation6
                                source: "meshes/hand.mesh"
                                materials: [plastic_material, steel_material]

                                Model {
                                    id: hand_grab_t_hinge_2
                                    x: -9.5112e-07
                                    y: 0.323057
                                    z: 0.472305
                                    eulerRotation: hand_grab_t_hinge_1.eulerRotation
                                    source: "meshes/hand_grab_t_hinge_2.mesh"
                                    materials: [steel_material]
                                }

                                Model {
                                    id: hand_grab_t_hinge_1
                                    x: -9.3061e-07
                                    y: 0.143685
                                    z: 0.728553
                                    eulerRotation.x: clawsAngle * -1
                                    source: "meshes/hand_grab_t_hinge_1.mesh"
                                    materials: [steel_material]

                                    Model {
                                        id: hand_grab_t
                                        x: -2.42588e-06
                                        y: -0.0327932
                                        z: 0.414757
                                        eulerRotation.x: hand_grab_t_hinge_1.eulerRotation.x * -1
                                        source: "meshes/hand_grab_t.mesh"
                                        materials: [plastic_color_material, steel_material]
                                    }
                                }

                                Model {
                                    id: hand_grab_b_hinge_1
                                    x: -9.38738e-07
                                    y: -0.143685
                                    z: 0.728553
                                    eulerRotation.x: clawsAngle
                                    source: "meshes/hand_grab_b_hinge_1.mesh"
                                    materials: [steel_material]

                                    Model {
                                        id: hand_grab_b
                                        x: -2.41775e-06
                                        y: 0.0327224
                                        z: 0.413965
                                        eulerRotation.x: hand_grab_b_hinge_1.eulerRotation.x * -1
                                        source: "meshes/hand_grab_b.mesh"
                                        materials: [plastic_color_material, steel_material]
                                    }
                                }

                                Model {
                                    id: hand_grab_b_hinge_2
                                    x: -9.5112e-07
                                    y: -0.323058
                                    z: 0.472305
                                    eulerRotation: hand_grab_b_hinge_1.eulerRotation
                                    source: "meshes/hand_grab_b_hinge_2.mesh"
                                    materials: [steel_material]
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Node {
        id: __materialLibrary__

        DefaultMaterial {
            id: steel_material
            objectName: "steel_material"
            diffuseColor: "#ff595959"
        }

        DefaultMaterial {
            id: plastic_material
            objectName: "plastic_material"
        }

        DefaultMaterial {
            id: plastic_color_material
            objectName: "plastic_color_material"
            diffuseColor: "#1e90ff"
        }
        
        DefaultMaterial {
            id: plastic_color_material2
            objectName: "plastic_color_material2"
            diffuseColor: "#1AD91A"
        }

        DefaultMaterial {
            id: plastic_qt_material
            objectName: "plastic_qt_material"
            diffuseMap: Texture {
                source: "maps/qt.png"
                pivotU: 0.5
                pivotV: 0.5
                generateMipmaps: true
                mipFilter: Texture.Linear
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;cameraSpeed3d:25;cameraSpeed3dMultiplier:1;matPrevEnvDoc:"SkyBox";matPrevEnvValueDoc:"preview_studio";matPrevModelDoc:"#Sphere"}
}
##^##*/
