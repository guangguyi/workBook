import lcm
import sys
import json
import time
from json import *
from Sim import SimHandler
from PyQt5.QtChart import *
import matplotlib.pyplot as plt
from PyQt5.QtQuick import QQuickView
from mpl_toolkits.mplot3d import Axes3D
from PyQt5.QtWidgets import QApplication
from matplotlib.backends.qt_compat import QtWidgets
from PyQt5.QtCore import QUrl, QObject, pyqtSignal, QTimer, QThread, pyqtSlot
fig = plt.figure()
ax1 = plt.gca()
# plt.xlim(-1000, 1000)
# plt.ylim(-20, 20)
# plt.xticks(np.linspace(-1000, 1000, 10))
# plt.yticks(np.linspace(-20, 20, 5))
ax1.spines['right'].set_color('none')
ax1.spines['top'].set_color('none')
ax1.xaxis.set_ticks_position('bottom')
ax1.yaxis.set_ticks_position('left')
ax1.spines['bottom'].set_position(('data', 0))
ax1.spines['left'].set_position(('data', 0))
plt.grid(False)

listA = []
listB = []
listC = []


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
        # 多线程的信号触发连接到up_data
        self.work.trigger.connect(self.up_data)

    def start(self):
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
        plt.savefig('output/new.png')
        plt.close()
        # time.sleep(5)
        # exit()

    def up_data(self):
        rootObject.setProperty("channelName", channelName)
        rootObject.setProperty("timestamp", timestamp)
        rootObject.setProperty("handler", handler)
        if handler == '0':
            json_value = json.loads(parameters)
            dict_value = json_value['objs']
            list_value_1 = dict_value[0]
            print(json_value)
            listA.append(list_value_1['px'])
            listB.append(list_value_1['pz'])
            listC.append(list_value_1['py'])
            x1 = list_value_1['px']
            y1 = list_value_1['pz']
            z1 = list_value_1['py']
            rootObject.setProperty("x_value", x1)
            rootObject.setProperty("y_value", y1)
            plt.subplot(111)
            plt.scatter(y1, x1, s=50, c='b', marker='.')
            plt.plot(listB, listA, 'r-', lw=1)


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
        # time.sleep(2)
        self.trigger.emit("ok")
        HandleWork.lc.handle()


if __name__ == "__main__":
    path = 'main.qml'
    app = QApplication(sys.argv)
    viewer = QQuickView()
    con = MainPanel()
    context = viewer.rootContext()
    context.setContextProperty("con", con)
    viewer.engine().quit.connect(app.quit)
    viewer.setResizeMode(QQuickView.SizeRootObjectToView)
    viewer.setSource(QUrl(path))
    rootObject = viewer.rootObject()
    viewer.show()
    app.exec_()
