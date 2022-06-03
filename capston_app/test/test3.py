from encodings import utf_8
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
from datetime import datetime, timedelta
import random
import json
from collections import OrderedDict
import time

emotions = ['angry', 'disgust', 'fear', 'happy', 'happy', 'happy', 'sad', 'surprise', 'neutral', 'neutral','neutral','neutral', 'neutral', 'neutral', 'neutral', 'neutral', 'neutral', 'neutral']

poses = ['lie', 'lie','lie','lie','lie','lie','lie_face_down', 'lie_side', 'lie_side', 'lie_side', 'lie_side', 'sit_cross_legged', 'sit_on_chair']

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

#Firebase database 인증 및 앱 초기화
cred = credentials.Certificate("capston-design-6d365-firebase-adminsdk-kkcq8-92db807e88.json")
firebase_admin.initialize_app(cred,{
    'databaseURL' : 'https://capston-design-6d365-default-rtdb.firebaseio.com/'
})
i = 28
while True:
    today = datetime.now() # 현재시간
    todayTimestamp = round(today.timestamp() * 1000000) #현재 타임스템프
    now = round(datetime.timestamp(today - timedelta(hours=5)) * 1000000)

    ref = db.reference('emotion_logs')
    data = {
        "emotion": 'neutral',
        "time": now
    }    
    ref.push(data)

    ref = db.reference('pose_logs')
    data = {
        "pose": 'lie',
        "time": now
    }    
    ref.push(data)

    ref = db.reference('sickroom_logs')
    data = {
        "humidity": random.randrange(40, 60),
        "temperature": random.randrange(20, 30),
        "time": now
    }    
    ref.push(data)
    i-=1
    print(i)
    time.sleep(5)
