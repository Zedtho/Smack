

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls
import Smack

Rectangle {
    id: root
    width: 1920
    height: Constants.height

    color: Constants.backgroundColor

    StackView {
        id: stackView
        x: 0
        y: 0
        width: 1796
        height: 1060

        Page {
            id: homepage
            x: 0
            y: 0
            width: 1920
            height: 1080
            z: 1
            enabled: true

            Rectangle {
                id: background
                x: 0
                y: 0
                width: 1920
                height: 1080
                color: "#eaeaea"

                Text {
                    id: goaltoday
                    x: 316
                    y: 197
                    width: 376
                    height: 71
                    text: "What is your goal today?"
                    font.pixelSize: 30
                    font.family: "Courier"
                }

                Rectangle {
                    id: planbackground
                    x: 316
                    y: 269
                    width: 443
                    height: 75
                    color: "#d2d2d2"

                    TextEdit {
                        id: textEdit
                        x: 8
                        y: 8
                        width: 419
                        height: 59
                        text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu Sans'; font-size:11pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Courier 10 Pitch'; font-size:14pt;\">1. Do Flashcards 2. Watch lectures</span></p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Courier 10 Pitch'; font-size:14pt;\"><br /></p></body></html>"
                        font.pixelSize: 12
                        clip: true
                        textFormat: Text.RichText
                    }
                }

                Button {
                    id: button
                    x: 324
                    y: 363
                    width: 110
                    height: 48
                    text: qsTr("Start")
                    highlighted: true
                    flat: true
                }
            }
        }

        Page {
            id: settingspage
            x: 0
            y: 0
            width: 1920
            height: 1080
            enabled: true
            Rectangle {
                id: background_s
                x: 0
                y: 0
                width: 1991
                height: 1080
                color: "#f6f5f4"
                Text {
                    id: apikey
                    x: 176
                    y: 70
                    width: 376
                    height: 71
                    text: "API-key for model"
                    font.pixelSize: 30
                    font.family: "Courier"

                    Rectangle {
                        id: apikeybackground
                        x: 0
                        y: 68
                        width: 662
                        height: 38
                        color: "#d2d2d2"
                        clip: true
                        TextInput {
                            id: textInput1
                            x: 9
                            y: 5
                            width: 479
                            height: 33
                            text: "sk-...."
                            font.pixelSize: 18
                            z: 2
                            font.family: "Courier"
                            clip: false
                        }
                    }

                    ComboBox {
                        id: selectmodel
                        x: 326
                        y: 3
                        width: 332
                        height: 40
                        model: ["Anthropic", "OpenAI", "Google", "Mistral"]
                    }
                }

                Text {
                    id: selfdescription
                    x: 176
                    y: 196
                    width: 370
                    height: 71
                    text: "self-description"
                    font.pixelSize: 30
                    font.family: "Courier"
                    Rectangle {
                        id: selfdescriptionbackground
                        x: 0
                        y: 52
                        width: 662
                        height: 79
                        color: "#d2d2d2"

                        TextEdit {
                            id: selfdescripttext
                            x: 8
                            y: 10
                            width: 646
                            height: 61
                            text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu Sans'; font-size:11pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Courier 10 Pitch'; font-size:18pt;\">Hi</span></p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Courier 10 Pitch'; font-size:18pt;\"><br /></p></body></html>"
                            clip: true
                            textFormat: Text.RichText
                            font.family: "Courier"
                        }
                    }
                }

                Text {
                    id: resistdeath
                    x: 176
                    y: 622
                    width: 376
                    height: 71
                    text: "resist death"
                    font.pixelSize: 30
                    font.family: "Courier"

                    Switch {
                        id: _switch
                        x: 326
                        y: 0
                    }
                }

                Text {
                    id: allow
                    x: 176
                    y: 360
                    width: 376
                    height: 71
                    text: "Allow website"
                    font.pixelSize: 30
                    font.family: "Courier"
                    Rectangle {
                        id: apikeybackground1
                        x: 0
                        y: 62
                        width: 662
                        height: 38
                        color: "#d2d2d2"
                        TextInput {
                            id: textInput2
                            x: 9
                            y: 5
                            width: 479
                            height: 33
                            text: "harvard.edu"
                            font.pixelSize: 18
                            z: 2
                            font.family: "Courier"
                            clip: true
                        }

                        Button {
                            id: button1
                            x: 562
                            y: 1
                            width: 100
                            height: 36
                            text: qsTr("Allow")
                            highlighted: true
                        }
                    }
                }

                Text {
                    id: startup
                    x: 176
                    y: 691
                    width: 376
                    height: 71
                    text: "run at start-up"
                    font.pixelSize: 30
                    font.family: "Courier"
                    Switch {
                        id: _switch1
                        x: 327
                        y: 0
                    }
                }

                Text {
                    id: startup1
                    x: 176
                    y: 762
                    width: 376
                    height: 71
                    text: "Pavlovian sounds"
                    font.pixelSize: 30
                    font.family: "Courier"
                    Switch {
                        id: _switch3
                        x: 327
                        y: 0
                    }
                }

                Text {
                    id: block
                    x: 176
                    y: 485
                    width: 376
                    height: 71
                    text: "Block website"
                    font.pixelSize: 30
                    font.family: "Courier"
                    Rectangle {
                        id: apikeybackground2
                        x: 0
                        y: 62
                        width: 662
                        height: 38
                        color: "#d2d2d2"
                        TextInput {
                            id: textInput3
                            x: 9
                            y: 5
                            width: 479
                            height: 33
                            text: "youtube.com"
                            font.pixelSize: 18
                            z: 2
                            font.family: "Courier"
                            clip: true
                        }
                    }

                    Button {
                        id: button2
                        x: 562
                        y: 63
                        width: 100
                        height: 36
                        text: qsTr("Block")
                        highlighted: true
                    }
                }
            }
        }

        Rectangle {
            id: sidebar
            x: 0
            y: 0
            width: 105
            height: 1080
            color: "#ffffff"
            z: 3

            Image {
                id: settingsicon
                x: 26
                y: 300
                width: 52
                height: 52
                source: "images/gear-solid.svg"
                z: 1
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    id: settingsmouse
                    anchors.fill: parent
                    anchors.leftMargin: -13
                    anchors.rightMargin: -11
                    anchors.bottomMargin: -33
                    hoverEnabled: true
                }

                Text {
                    id: settings
                    x: 5
                    y: 65
                    width: 52
                    height: 15
                    text: qsTr("Settings")
                    font.pixelSize: 12
                    scale: 1.25
                    transformOrigin: Item.Center
                    z: 1
                }
            }

            Image {
                id: logo
                x: 17
                y: 33
                width: 71
                height: 81
                source: "images/icon.png"
                z: 1
                fillMode: Image.PreserveAspectFit
            }

            Image {
                id: homeicon
                x: -141
                y: 33
                width: 386
                height: 343
                source: "house-solid.svg"
                scale: 0.15
                fillMode: Image.PreserveAspectFit
                MouseArea {
                    id: homemouse
                    anchors.fill: parent
                    anchors.leftMargin: -210
                    anchors.rightMargin: -164
                    anchors.topMargin: -1079
                    anchors.bottomMargin: -259
                    hoverEnabled: true

                    Text {
                        id: _text
                        x: 390
                        y: 1551
                        text: qsTr("Home")
                        font.pixelSize: 12
                        scale: 9
                    }
                }
            }
        }

        Connections {
            target: stackView
            onEnabledChanged: console.log("clicked")
        }

        Connections {
            target: settingsmouse
            onPressed: {
                settingsicon.scale = 1.13333
                settingsicon.opacity = 1
            }

            onReleased: {
                settingsicon.scale = 1
            }
            onClicked: {
                stackView.replace(settingspage)
            }
            onEntered: {
                settingsicon.opacity = 0.7
            }

            onExited: {
                settingsicon.opacity = 1
            }
        }

        Connections {
            target: homemouse
            onPressed: {
                homeicon.scale = 0.17
                homeicon.opacity = 1
            }

            onReleased: {
                homeicon.scale = 0.15
            }
            onEntered: {
                homeicon.opacity = 0.7
            }

            onExited: {
                homeicon.opacity = 1
            }

            onClicked: {
                stackView.replace(homepage)
            }
        }
    }
}

/*##^##
Designer {
    D{i:0}D{i:2;invisible:true}
}
##^##*/
