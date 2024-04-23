import sys
import signal
import os
import time

import pygame

import cv2
from pyzbar.pyzbar import decode
from publish import Publisher
import AWSIoTPythonSDK


# grab Amazon Cognito ID from command line arguments
cognitoID = sys.argv[1] if len(sys.argv) > 1 else "test"

# CSI camera setup function
def gstreamer_pipeline(
    capture_width=1280, # previously 3264
    capture_height=720, # previously 2464
    display_width=640,
    display_height=360,
    framerate=59, # previously 21
    flip_method=0,
):
    return (
        "nvarguscamerasrc ! "
        "video/x-raw(memory:NVMM), "
        "width=(int)%d, height=(int)%d, framerate=(fraction)%d/1 ! "
        "nvvidconv flip-method=%d ! "
        "video/x-raw, width=(int)%d, height=(int)%d, format=(string)BGRx ! "
        "videoconvert ! "
        "video/x-raw, format=(string)BGR ! appsink drop=True"
        % (
            capture_width,
            capture_height,
            framerate,
            flip_method,
            display_width,
            display_height,
        )
    )

# create sounds
pygame.init()
pygame.mixer.init()

pub_connected_sound = pygame.mixer.Sound('sounds/publisher-connected-audio.mp3')
barcode_detected_sound = pygame.mixer.Sound('sounds/barcode-detected-audio.mp3')
publish_failed_sound = pygame.mixer.Sound('sounds/publish-failed-audio.mp3')
program_terminated_sound = pygame.mixer.Sound('sounds/program-terminated-audio.mp3')


# function to handle KILL command
def sigterm_handler(signal, frame):
    print("SIGTERM RECEIVED, attempting to exit gracefully")
    # disconnect MQTT client from AWS
    # publish.disconnect_client()
    print("Releasing gstreamer camera")
    cap.release()
    print("Released successfully")
    # play exit sound
    program_terminated_sound.play()
    time.sleep(2)
    sys.exit(0)


# set up signal handler for kill command
signal.signal(signal.SIGTERM, sigterm_handler)

# initiate camera capture
camera_id = gstreamer_pipeline()
cap = cv2.VideoCapture(camera_id, cv2.CAP_GSTREAMER)


def main():
    # save down PID to later kill programmatically
    PID = str(os.getpid())
    with open('app.pid', 'w') as file:
        file.write(PID)

    # publisher instance
    publisher = Publisher(cognitoID)
    # connect to AWS MQTT broker in IoTCore, specify cognitoID to publish to that specific topic
    publisher.connect_client()

    # play "connected" sound
    pub_connected_sound.play()

    # set timeout to 5 minutes
    timeout = time.time() + 60*3

    # dict to store barcode results to be published to IoT Core
    dict_keys = ['cognitoID','barcode','start_time']
    result = dict.fromkeys(dict_keys)

    result['cognitoID'] = cognitoID

    img_counter = 0
    while True:
        if time.time() > timeout:
            print("Timed out due to inactivity.")
            break

        ret, frame = cap.read()
        img_counter += 1

        if ret and (img_counter % 15) == 0:
            for d in decode(frame):
                result['start_time'] = int(time.time())
                s = d.data.decode()

                #frame = cv2.rectangle(frame, (d.rect.left, d.rect.top), (d.rect.left + d.rect.width, d.rect.top + d.rect.height), (0, 255, 0), 3)
                #frame = cv2.putText(frame, s, (d.rect.left, d.rect.top + d.rect.height), cv2.FONT_HERSHEY_SIMPLEX, 2, (0, 0, 255), 2, cv2.LINE_AA)

                # publish data to AWS
                result['barcode'] = s

                # extend timeout
                timeout = time.time() + 60*3
                
                try:
                    publisher.publish_data(result)
                    # play detected sound
                    barcode_detected_sound.play()
                    time.sleep(2)
                except AWSIoTPythonSDK.exception.AWSIoTExceptions.publishTimeoutException as e:
                    print(e)
                    # play failed publish sound
                    publish_failed_sound.play()

    # disconnect MQTT client from AWS
    # publisher.disconnect_client()
    print("Released camera")
    cap.release()
    program_terminated_sound.play()
    time.sleep(2)

if __name__ == '__main__':
    main()
