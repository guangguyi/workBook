from PyQt5 import QtCore
from PyQt5.QtWidgets import *
from PyQt5.QtCore import *
import sys
import os


class Ui_MainWindow(QMainWindow):

    def __init__(self):
        super(Ui_MainWindow, self).__init__()
        self.setupUi(self)
        self.retranslateUi(self)

    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(386, 127)
        self.centralWidget = QWidget(MainWindow)
        self.centralWidget.setObjectName("centralWidget")
        self.retranslateUi(MainWindow)
        self.pushButton = QPushButton(self.centralWidget)
        self.pushButton.setGeometry(QtCore.QRect(150, 50, 75, 23))
        self.pushButton.setObjectName("pushButton")
        self.pushButton.setText("aa")
        MainWindow.setCentralWidget(self.centralWidget)
        QMetaObject.connectSlotsByName(MainWindow)

        self.pushButton.clicked.connect(self.openfile)

    def retranslateUi(self, MainWindow):
        _translate = QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "aa"))

    def openfile(self):
        openfile_name = QFileDialog.getOpenFileName(self, 'aa', '', 'LCM(*.lcm)')
        fileName = openfile_name[0]
        print(fileName)
        os.system('lcm-gen -j ' + fileName)
        QMessageBox.information(self, "aa", "aa", QMessageBox.Yes | QMessageBox.No)
        sys.exit(0)


if __name__ == "__main__":
    app = QApplication(sys.argv)
    MainWindow = QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec_())
