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

emotion_logs = []
pose_logs = []
data = OrderedDict()
data['emotion_logs'] = emotion_logs
data['pose_logs'] = pose_logs
data['name'] = '김부기'
emotions = ['angry', 'disgust', 'fear', 'happy', 'happy', 'happy', 'sad', 'surprise', 'neutral', 'neutral','neutral','neutral', 'neutral', 'neutral', 'neutral', 'neutral', 'neutral', 'neutral']

poses = ['lie', 'lie_face_down', 'lie_side', 'sit_cross_legged', 'sit_on_chair']

today = datetime.now() # 현재시간
todayTimestamp = round(today.timestamp() * 1000000) #현재 타임스템프

for i in range(29, -1, -1):
    referenceTime = round(datetime.timestamp(today + timedelta(days=-i)))
    for j in range(23, 3, -1):
        dt = datetime.fromtimestamp(referenceTime) #타임스템프를 date로
        time = round(datetime.timestamp(dt + timedelta(hours=-j)) * 1000000)
        emotion_logs.append(Emotion(random.sample(emotions, 1)[0], time))
        pose_logs.append(Pose(random.sample(poses, 1)[0], time))


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