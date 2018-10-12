import sys
import time
from PyQt5 import QtWidgets
from PyQt5.QtCore import QTimer, QThread, pyqtSignal
from mainwindow import Ui_MainWindow
import lcm
from Sim import SimHandler
from json import *


class MainWindow(QtWidgets.QMainWindow, Ui_MainWindow):

    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent=parent)
        self.setupUi(self)
        # 初始化一个定时器
        self.timer = QTimer(self)
        # 定义时间超时连接start_app
        self.timer.timeout.connect(self.start)
        # 定义时间任务是一次性任务
        self.timer.setSingleShot(False)
        # 启动时   间任务
        self.timer.start()
        # 实例化一个线程
        self.work = WorkThread()
        # 多线程的信号触发连接到UpText
        self.work.trigger.connect(self.UpText)

    def start(self):
        # time.sleep(2)
        # self.textBrowser.append('test1')
        # 启动另一个线程
        self.work.start()

    def controlHor(self, value):
        lc = lcm.LCM("udpm://239.255.76.67:7667?ttl=1")
        msg = SimHandler()
        dictValue = eval("{\"horizontal\" : 0, \"vertical\" : 0}")
        dictValue["horizontal"] = (value / 100.0 - 0.5)
        jsonValue = JSONEncoder().encode(dictValue)
        msg.timestamp = int(time.time() * 1000000)
        msg.parameters = jsonValue
        msg.handler = 1
        lc.publish("SIMULATOR", msg.encode())

    def controlVer(self, value):
        lc = lcm.LCM("udpm://239.255.76.67:7667?ttl=1")
        msg = SimHandler()
        dictValue = eval("{\"horizontal\" : 0, \"vertical\" : 0}")
        dictValue["vertical"] = (value / 100.0 - 0.5) * 2
        jsonValue = JSONEncoder().encode(dictValue)
        msg.timestamp = int(time.time() * 1000000)
        msg.parameters = jsonValue
        msg.handler = 1
        lc.publish("SIMULATOR", msg.encode())

    def startWork(self):
        lc = lcm.LCM("udpm://239.255.76.67:7667?ttl=1")
        msg = SimHandler()
        msg.timestamp = int(time.time() * 1000000)
        msg.parameters = str("highway")
        msg.handler = 2
        lc.publish("SIMULATOR", msg.encode())

    def stopWork(self):
        lc = lcm.LCM("udpm://239.255.76.67:7667?ttl=1")
        msg = SimHandler()
        msg.timestamp = int(time.time() * 1000000)
        msg.parameters = str("")
        msg.handler = -2
        lc.publish("SIMULATOR", msg.encode())

    def UpText(self, str):
        listB = [channelName, timestamp, handler, parameters]
        for i in listB:
            self.textBrowser.append(i)


channelName = ""
timestamp = ""
handler = ""
parameters = ""


class HandleWork(MainWindow):
    def my_handler(channel, data):
        msg = SimHandler.decode(data)
        global channelName
        global timestamp
        global handler
        global parameters

        channelName = channel
        timestamp = str(msg.timestamp)
        handler = str(msg.handler)
        parameters = str(msg.parameters)

    lc = lcm.LCM()
    subscription = lc.subscribe("SIMULATOR", my_handler)


class WorkThread(QThread):
    # 定义一个信号
    trigger = pyqtSignal(str)

    def __int__(self):
        # 初始化函数，默认
        super(WorkThread, self).__init__()

    def run(self):
        print("SSSSSSSSSSSSSSSSSS")
        # 等待5秒后，给触发信号，并传递test
        self.trigger.emit("ok")
        HandleWork.lc.handle()


if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    w = MainWindow()
    sys.exit(app.exec_())
