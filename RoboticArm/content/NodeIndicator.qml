// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick3D

Item {
    id: root
    property real size: 100
    property bool isFocused: false
    property View3D view3D: parent
    property vector3d scenePosition
    property vector3d screenPosition
    property alias label: label.text

    x: screenPosition.x
    y: screenPosition.y

    visible: x > 0 && y > 0

    Label {
        id: label
        enabled: root.isFocused
        anchors.bottom: rect.top
        anchors.horizontalCenter: rect.horizontalCenter
    }

    Rectangle {
        id: rect
        width: root.size
        height: root.size
        color: root.isFocused ? "#FFA500": "Transparent"
		radius: 10 
        border.width: 2
        //border.color: root.isFocused ? Material.accentColor : Material.secondaryTextColor
        border.color: root.isFocused ? "#FFA500": "#aaaaaa"

        anchors.horizontalCenter: parent.left
        anchors.verticalCenter: parent.top
    }

    Item {
        id: __materialLibrary__
    }

    Component.onCompleted:  {
        screenPosition =  Qt.binding(function() {
            let w = view3D.width // force the binding to update when width or height changes
            let h = view3D.height

            return view3D.mapFrom3DScene(scenePosition)
        } )
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
