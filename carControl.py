import time
import lcm
from PyQt5.QtCore import QUrl, QObject, pyqtSignal, QTimer, QThread, pyqtSlot
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQuick import QQuickView
from Sim import SimHandler
from json import *


class MainPanel(QObject):
    def __init__(self, parent=None):
        super(QObject, self).__init__(parent=parent)
        # 初始化一个定时器
        self.timer = QTimer(self)
        # 定义时间超时连接start_app
        self.timer.timeout.connect(self.start)
        # 定义时间任务是一次性任务
        self.timer.setSingleShot(False)
        # 启动时间任务
        self.timer.start()
        # 实例化一个线程
        self.work = WorkThread()
        # 多线程的信号触发连接到upText
        self.work.trigger.connect(self.upText)

    def start(self):
        # time.sleep(2)
        # self.textBrowser.append('test1')
        # plt.pause(0.001)
        self.work.start()

    @pyqtSlot(int)
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

    @pyqtSlot(int)
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

    @pyqtSlot()
    def startWork(self):
        lc = lcm.LCM("udpm://239.255.76.67:7667?ttl=1")
        msg = SimHandler()
        msg.timestamp = int(time.time() * 1000000)
        msg.parameters = str("highway")
        msg.handler = 2
        lc.publish("SIMULATOR", msg.encode())

    @pyqtSlot()
    def stopWork(self):
        lc = lcm.LCM("udpm://239.255.76.67:7667?ttl=1")
        msg = SimHandler()
        msg.timestamp = int(time.time() * 1000000)
        msg.parameters = str("")
        msg.handler = -2
        lc.publish("SIMULATOR", msg.encode())

    def upText(self):
        rootObject.setProperty("channelName", channelName)
        rootObject.setProperty("timestamp", timestamp)
        rootObject.setProperty("handler", handler)
        rootObject.setProperty("parameters", parameters)


channelName = ""
timestamp = ""
handler = ""
parameters = ""


class HandleWork(MainPanel):
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
        # 等待5秒后，给触发信号，并传递test
        # time.sleep(2)
        self.trigger.emit("ok")
        HandleWork.lc.handle()


if __name__ == "__main__":
    path = 'main.qml'
    app = QGuiApplication([])
    viewer = QQuickView()   
    con = MainPanel()
    context = viewer.rootContext()
    context.setContextProperty("con", con)
    viewer.engine().quit.connect(app.quit)
    viewer.setSource(QUrl(path))
    rootObject = viewer.rootObject()
    viewer.show()
    app.exec_()
