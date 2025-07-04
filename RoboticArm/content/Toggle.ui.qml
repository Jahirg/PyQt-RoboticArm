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

Item {
    property string text
    property alias checked: toggleIndicator.checked
    readonly property alias hasFocus: toggleIndicator.activeFocus
    implicitWidth: toggleText.width + toggleIndicator.width
    implicitHeight: 50

    Label {
        id: toggleText
        text: parent.text
        anchors.verticalCenter: toggleIndicator.verticalCenter
    }
    Switch {
        id: toggleIndicator
        anchors.left: toggleText.right
        anchors.rightMargin: 8
        //
        
        indicator: Rectangle {
			implicitWidth: 48
			implicitHeight: 26
			x: toggleIndicator.leftPadding
			y: parent.height / 2 - height / 2
			radius: 13
			color: toggleIndicator.checked ? "#99CDFF" : "#CCCCCC"
			border.color: toggleIndicator.checked ? "#99CDFF" : "#888888"
			border.width: 2

			Rectangle {
				x: toggleIndicator.checked ? parent.width - width : 0
				width: 26
				height: 26
				radius: 13
				color: toggleIndicator.checked ? "#1E90FF" : "#99CDFF"
				//color: toggleIndicator.down ? "#FF0000" : "#ffffff"
				border.color: toggleIndicator.checked ? (toggleIndicator.down ? "#FF0000" : "#1E90FF") : "#888888"
				border.width: 3
			}
		}

		contentItem: Text {
			text: toggleIndicator.text
			font: toggleIndicator.font
			opacity: enabled ? 1.0 : 0.3
			color: toggleIndicator.down ? "#17a81a" : "#21be2b"
			verticalAlignment: Text.AlignVCenter
			leftPadding: toggleIndicator.indicator.width + toggleIndicator.spacing
		}
		
        //
    }
}
