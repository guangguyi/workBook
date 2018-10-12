import lcm
from PyQt5.QtCore import QObject, pyqtSignal, QTimer, QThread
from dem import example_t
# from exlcm import example_t
import matplotlib.pyplot as plt
from PyQt5.QtWidgets import *
from mpl_toolkits.mplot3d import Axes3D
import sys
import time
import numpy as np

fig = plt.figure()
ax2 = fig.add_subplot(121, projection='3d')


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
        # 多线程的信号触发连接到upData
        self.work.trigger.connect(self.upData)

    def start(self):
        plt.pause(0.001)
        self.work.start()

    def upData(self):
        time.sleep(1)
        x = int(GPS_Longitude_Info) - 121242397
        y = int(GPS_Latitude_info) - 30339104

        # 绘制点
        print("QWERTYUIOP", GPS_Longitude_Info, GPS_Latitude_info)

        # 2D description Longitude and Latitude
        plt.subplot(1, 2, 2)
        plt.xlim(-4000, 4000)
        plt.ylim(-2000, 2000)
        plt.xticks(np.linspace(-4000, 4000, 20))
        plt.yticks(np.linspace(-2000, 2000, 20))
        ax1 = plt.gca()
        ax1.spines['right'].set_color('none')
        ax1.spines['top'].set_color('none')
        ax1.xaxis.set_ticks_position('bottom')
        ax1.yaxis.set_ticks_position('left')
        ax1.spines['bottom'].set_position(('data', 0))
        ax1.spines['left'].set_position(('data', 0))
        plt.title('Earth')
        plt.grid(False)
        plt.scatter(x, y)

        # 3D description point cloud
        plt.title('Point Cloud')
        ax2.set_xlim(-4000, 4000)
        ax2.set_ylim(-2000, 2000)
        ax2.set_zlim(-1000, 1000)
        ax2.scatter(x, y, 600, c='g', marker='*')
        ax2.set_xlabel('X Label')
        ax2.set_ylabel('Y Label')
        ax2.set_zlabel('Z Label')


GPS_Longitude_Info = 0
GPS_Latitude_info = 0


class HandleWork(MainPanel):
    def my_handler(channel, data):
        msg = example_t.decode(data)
        global GPS_Latitude_info
        global GPS_Longitude_Info
        GPS_Longitude_Info = str(msg.GPS_Longitude_Info)
        GPS_Latitude_info = str(msg.GPS_Latitude_info)

    lc = lcm.LCM("udpm://239.255.76.67:7667?ttl=1")
    subscription = lc.subscribe("RCV-DEM", my_handler)
    # subscription = lc.subscribe("EXAMPLE", my_handler)


class WorkThread(QThread):
    # 定义一个信号
    trigger = pyqtSignal(str)

    def __int__(self):
        # 初始化函数，默认
        super(WorkThread, self).__init__()

    def run(self):
        self.trigger.emit("ok")
        HandleWork.lc.handle()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    w = MainPanel()
    sys.exit(app.exec_())
