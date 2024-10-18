import socket
import matplotlib.pyplot as plt
import numpy as np
import time

z = np.arange(0, 20, 0.5)
x = np.cos(z)
y = np.sin(z)

host = "10.101.99.136" #Processingで立ち上げたサーバのIPアドレス
port = 10001       #Processingで設定したポート番号

if __name__ == '__main__':
    socket_client = socket.socket(socket.AF_INET, socket.SOCK_STREAM) #オブジェクトの作成
    socket_client.connect((host, port))                               #サーバに接続

    #socket_client.send('送信するメッセージ')                #データを送信 Python2
    #socket_client.send(k.encode('utf-8')) #データを送信 Python3
    
    #socket_client.send(l.encode('utf-8')) #データを送信 Python3
for i in np.arange(0.0,20.0,0.5):
    #print("FFFF," + str(i*10) + "," + str(round(np.sin(i),3)*100 + 150) + "," + str(round(np.cos(i),3)*100 + 150) + "," + str((i+0.5)*10) + "," + str(round(np.sin(i+0.5),3)*100 + 150) + "," + str(round(np.cos(i+0.5),3)*100 + 150))
    #socket_client.send(("FFFF," + str(i*10) + "," + str(round(np.sin(i),3)*100 + 150) + "," + str(round(np.cos(i),3)*100 + 150) + "," + str((i+0.5)*10) + "," + str(round(np.sin(i+0.5),3)*100 + 150) + "," + str(round(np.cos(i+0.5),3)*100 + 150)).encode('utf-8'))
    #time.sleep(0.07)
    print("FFFF," + str(i*10) + "," + str(round(np.sin(i),3)*100 + 150) + "," + str(round(np.cos(i),3)*100 + 150))
    socket_client.send(("FFFF," + str(i*10) + "," + str(round(np.sin(i),3)*100 + 150) + "," + str(round(np.cos(i),3)*100 + 150)).encode('utf-8'))
    time.sleep(0.07)
#socket_client.send(("1111," + str(200) + "," + str(round(np.sin(20),3)*100 + 150) + "," + str(round(np.cos(20),3)*100 + 150) + "," + str((20+0.5)*10) + "," + str(round(np.sin(20+0.5),3)*100 + 150) + "," + str(round(np.cos(20+0.5),3)*100 + 150)).encode('utf-8'))
socket_client.send(("FFFF," + str(200) + "," + str(round(np.sin(20),3)*100 + 150) + "," + str(round(np.cos(20),3)*100 + 150)).encode('utf-8'))
time.sleep(0.07)
socket_client.send(("AAAA," + str(1) + "," + str(1) + "," + str(1)).encode('utf-8'))
time.sleep(0.07)
for i in np.arange(0.0, 20.0, 0.5):
    print("FFFF," + str(i*10) + "," + str(round(np.cos(i),3)*100 + 150) + "," + str(round(np.sin(i),3)*100 + 150))
    socket_client.send(("FFFF," + str(round(np.cos(i),3)*100 + 150) + "," + str(round(np.sin(i),3)*100 + 150) + "," + str(i*10)).encode('utf-8'))
    time.sleep(0.07)
socket_client.send(("1111," + str(round(np.cos(20),3)*100 + 150) + "," + str(round(np.sin(20),3)*100 + 150) + "," + str(200)).encode('utf-8'))
socket_client.close()