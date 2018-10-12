from PyQt5.QtWidgets import *
from PyQt5.QtCore import *


class Ui_MainWindow(QWidget):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(1000, 800)
        self.centralwidget = QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.textBrowser = QTextBrowser(self.centralwidget)
        self.textBrowser.setGeometry(QRect(600, 0, 400, 800))
        self.textBrowser.setObjectName("textBrowser")

        timestamp = QLabel('横向控制')
        handler = QLabel('纵向控制')
        # parameters = QLabel('json字符串')
        #
        # self.timestampEdit = QLineEdit()
        # self.handlerEdit = QLineEdit()
        # self.parametersEdit = QLineEdit()
        grid = QGridLayout(self.centralwidget)

        grid.addWidget(timestamp, 4, 6, 1, 1, Qt.AlignLeft)
        # grid.addWidget(self.timestampEdit, 1, 6, 1, 10, Qt.AlignLeft)
        grid.addWidget(handler, 5, 6, 1, 1, Qt.AlignLeft)
        # grid.addWidget(self.handlerEdit, 2, 6, 1, 10, Qt.AlignLeft)
        # grid.addWidget(parameters, 3, 5, 1, 1, Qt.AlignLeft)
        # grid.addWidget(self.parametersEdit, 3, 6, 1, 10, Qt.AlignLeft)
        # 水平控制
        sldHor = QSlider(Qt.Horizontal, self)
        sldHor.setFocusPolicy(Qt.NoFocus)
        sldHor.setGeometry(200, 300, 200, 30)
        sldHor.valueChanged[int].connect(MainWindow.controlHor)
        # 加减速控制
        sldVer = QSlider(Qt.Vertical, self)
        sldVer.setFocusPolicy(Qt.StrongFocus)
        sldVer.setGeometry(290, 350, 30, 200)
        sldVer.valueChanged[int].connect(MainWindow.controlVer)

        startWork = QPushButton('进入')
        grid.addWidget(startWork, 4, 4, 1, 1, Qt.AlignLeft)
        startWork.clicked.connect(MainWindow.startWork)

        stopWork = QPushButton('退出')
        grid.addWidget(stopWork, 5, 4, 1, 1, Qt.AlignLeft)
        stopWork.clicked.connect(MainWindow.stopWork)

        MainWindow.setCentralWidget(self.centralwidget)

        self.retranslateUi(MainWindow)
        # self.pushButton.clicked.connect(MainWindow.start)
        QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
        # self.pushButton.setText(_translate("MainWindow", "开始"))




