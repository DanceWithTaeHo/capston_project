import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
from datetime import datetime, timedelta



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
    "emotion": "sad",
    "time": 1652980716
}
print(round(datetime.timestamp(today + timedelta(hours=-2)) * 1000000))
print(round(datetime.timestamp(today + timedelta(hours=-1)) * 1000000))
print(todayTimestamp)

# ref = db.reference('emotion_logs')
# ref.push(data)
# x = ref.get()