/*
 * This file is part of Kalk
 * Copyright (C) 2016 Pierre Jacquier <pierrejacquier39@gmail.com>
 *
 *               2020 Cahfofpai
 *                    Han Young <hanyoung@protonmail.com>
 *
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 */
import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1 as Controls
import Qt.labs.platform 1.0
import Qt.labs.settings 1.0
import ".."
import "../engine"
import org.kde.kirigami 2.13 as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: 'Kalk'
    visible: true
    controlsVisible: false
    height: Kirigami.Units.gridUnit * 45
    width: Kirigami.Units.gridUnit * 27

    property string history: ''

    property string lastFormula
    property string lastError
    property int smallSpacing: 10
    Kirigami.SwipeNavigator {
        anchors.fill: parent
        Kirigami.Page {
            icon.name: "accessories-calculator"
            id: initialPage
            title: i18n("Calculation")
            leftPadding: 0
            rightPadding: 0
            bottomPadding: 0
            Loader {
                id: mathJsLoader
                source: "qrc:///engine/MathJs.qml"
                asynchronous: true
                active: true
                onLoaded: {
                    mathJs.config({
                                      number: 'BigNumber'
                                  });
                }
            }

            CalculationZone {
                id: calculationZone
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height - swipeView.height
            }

            NumberPad {
                id: swipeView
                height: parent.height * 0.8
                width: parent.width
                anchors.bottom: parent.bottom
            }
        }

        UnitConversion {
            icon.name: "gtk-convert"
            id: unitConversion
        }

        HistoryView {
            icon.name: "shallow-history"
            id: historyView
            visible: false
        }

        Kirigami.AboutPage {
            icon.name: "help-about"
            id: aboutPage
            visible: false
            title: i18n("About")
            aboutData: {
                "displayName": "Calculator",
                "productName": "kirigami/calculator",
                "componentName": "kalk",
                "shortDescription": "A mobile friendly calculator built with Kirigami.",
                "homepage": "",
                "bugAddress": "",
                "version": "0.1",
                "otherText": "Kalk started as a fork of Liri calculator, many components have
                been rewritten since then.",
                "copyrightStatement": "© 2020 Plasma Development Team",
                "desktopFileName": "org.kde.kalk",
                "authors": [
                            {
                                "name": "cahfofpai",
                                //"emailAddress": "",
                            },
                            {
                                "name": "Han Young",
                                "emailAddress": "hanyoung@protonmail.com",
                            }
                        ],
                "licenses": [
                            {
                                "name" : "GPL v3.0",
                                //"text" : "https://fsf.org",
                                "spdx" : "GPL-v3.0",
                            }
                        ]
            }
        }

    }

    property var mathJs: mathJsLoader.item ? mathJsLoader.item.mathJs : null;
}