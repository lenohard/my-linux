import os
import face_recognition
import time
from PIL import Image, ImageDraw
import numpy as np
import cv2

her_image = face_recognition.load_image_file("her.png")
her_face_encoding = face_recognition.face_encodings(her_image)[0]

# Load a second sample picture and learn how to recognize it.
he_image = face_recognition.load_image_file("i4.png")
he_face_encoding = face_recognition.face_encodings(he_image)[0]

# Create arrays of known face encodings and their names
known_face_encodings = [
    her_face_encoding,
    he_face_encoding
]
known_face_names = [
    "she",
    "he"
]

# Load an image with an unknown face
def recognize(file):
    unknown_image = face_recognition.load_image_file(file)

    # Find all the faces and face encodings in the unknown image
    face_locations = face_recognition.face_locations(unknown_image)
    face_encodings = face_recognition.face_encodings(unknown_image, face_locations)

    q = False
    for (top, right, bottom, left), face_encoding in zip(face_locations, face_encodings):
        # See if the face is a match for the known face(s)
        matches = face_recognition.compare_faces(known_face_encodings, face_encoding)

        name = "Unknown"

        face_distances = face_recognition.face_distance(known_face_encodings, face_encoding)
        best_match_index = np.argmin(face_distances)
        if matches[best_match_index]:
            name = known_face_names[best_match_index]
            if name == 'she':
                q = True
                break
    return q

cap = cv2.VideoCapture('/mnt/data/half/half.mkv')
amount_of_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
print("total {}".format(amount_of_frames))
frame_no = 8000
step = 100
cap.set(1,frame_no)
count = 0
while cap.isOpened():
    cap.set(1,frame_no);
    ret,frame = cap.read()
    if ret:
        file_name = "frame%d.jpg"%frame_no
        cv2.imwrite(file_name, frame)
        frame_no = frame_no + step
        if (recognize(file_name)):
            # file_name2 = "face2/frame%d.jpg"%count
            # cv2.imwrite(file_name2, frame)
            step = 1
            count = count + 1
            cv2.imshow('averst',frame)
            filename = "{}_{}.jpg".(frame_no, count)
            path = "/home/carl/Pictures/Averst"
            path = os.path.join(path, filename)
            print("saving frame {}, total {}".format(path, count))
            cv2.imwrite(path, frame)
        else:
            step = 100
        print("sacanned {} frames ({:.2f}%) ".format(frame_no, frame_no * 100 / amount_of_frames))
        if cv2.waitKey(10) & 0xFF == ord('q'):
            break
    else:
        print("read failure")
        break


cap.release()
cv2.destroyAllWindows()  # destroy all the opened windows
