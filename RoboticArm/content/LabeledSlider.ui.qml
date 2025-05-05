// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls

Slider {
	id:control
    property string labelText: qsTr("Text")
    stepSize: 0.1
    background: Rectangle {
		x: control.leftPadding
		y: control.topPadding + control.availableHeight / 2 - height / 2
		implicitWidth: 200
		implicitHeight: 4
		width: control.availableWidth
		height: implicitHeight
		radius: 2
		color: "#c0c0c0"
		Rectangle {
			width: control.visualPosition * parent.width
			height: parent.height
			color: "#1e90ff"
			radius: 2
		}
	}
	handle: Rectangle {
		x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
		y: control.topPadding + control.availableHeight / 2 - height / 2
		implicitWidth: 12
		implicitHeight: 12
		radius: 6
		color: control.pressed ? "#f0f0f0" : "#f6f6f6"
		border.color: "#bdbebf"
	}
    Label {
        text: parent.labelText
        anchors.left: parent.left
        anchors.bottom: parent.top
        bottomPadding: -5
    }
    Label {
		text: parent.value.toFixed(2)
        anchors.right: parent.right
        anchors.bottom: parent.top
        bottomPadding: -5
    }
    
}
