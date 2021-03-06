import lcm
import sys
import json
import time
from json import *
from Sim import SimHandler

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
