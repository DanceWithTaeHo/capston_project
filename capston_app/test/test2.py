from encodings import utf_8
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
from datetime import datetime, timedelta
import random
import json
from collections import OrderedDict

class Emotion:
    def __init__(self, emotion, time):
        self.emotion = emotion
        self.time = time
    def __str__(self):
        return "emotion:{0},time:{1}".format(self.emotion, self.time)
    def __repr__(self):
        return "emotion:{0},time:{1}".format(self.emotion, self.time)
class Pose:
    def __init__(self, pose, time):
        self.pose = pose
        self.time = time
    def __str__(self):
        return "pose:{0},time:{1}".format(self.pose, self.time)
    def __repr__(self):
        return "pose:{0},time:{1}".format(self.pose, self.time)

class TemperatureAndHumidity:
    def __init__(self, temperature, humidity, time):
        self.temperature = temperature
        self.humidity = humidity
        self.time = time
    def __str__(self):
        return "pose:{0},pose:{1},time:{2}".format(self.temperature, self.humidity, self.time)
    def __repr__(self):
        return "pose:{0},pose:{1},time:{2}".format(self.temperature, self.humidity, self.time)

temperatureAndHumidity_logs = []
data = OrderedDict()
data['temperatureAndHumidity_logs'] = temperatureAndHumidity_logs

today = datetime.now() # 현재시간
todayTimestamp = round(today.timestamp() * 1000000) #현재 타임스템프

for i in range(100, 0, -1):
    #타임스템프를 date로
    time = round(datetime.timestamp(today - timedelta(minutes=-i*5)) * 1000000)
    temperatureAndHumidity_logs.append(TemperatureAndHumidity(random.randrange(20, 25), random.randrange(50, 60), time))

with open('words2.json', 'w', encoding='utf-8') as make_file:
    json.dump(data, make_file, ensure_ascii=False, indent="\t",  default=lambda x: x.__dict__)
"""
#Firebase database 인증 및 앱 초기화
cred = credentials.Certificate("capston-design-6d365-firebase-adminsdk-kkcq8-92db807e88.json")
firebase_admin.initialize_app(cred,{
    'databaseURL' : 'https://capston-design-6d365-default-rtdb.firebaseio.com/'
})


today = datetime.now() # 현재시간
todayTimestamp = round(today.timestamp() * 1000000) #현재 타임스템프
x = datetime.timestamp(today + timedelta(hours=4))
# print(x)

# dt = datetime.fromtimestamp(todayTimestamp) #현재 타임스템프를 date로
# print(dt.strftime('%Y%m%d %H:%M:%S')) # 포멧화

data = {
    "emotion": "neutral",
    "time": 1653536550315259
}
# print(round(datetime.timestamp(today + timedelta(hours=-2)) * 1000000))
# print(round(datetime.timestamp(today + timedelta(hours=-1)) * 1000000))
# print(todayTimestamp)

ref = db.reference('emotion_logs')
ref.push(data)
# x = ref.get()
"""