import math
import os
import wave
import struct

OUT_DIRS = [
    'android/app/src/main/res/raw',
    'assets/sounds',
]

SOUNDS = [
    ('preopen.wav', 660),
    ('regime.wav', 880),
    ('manage.wav', 740),
    ('exit.wav', 520),
]

DURATION_S = 0.35
SAMPLE_RATE = 44100
VOLUME = 0.35


def write_beep(path: str, freq: float):
    n = int(DURATION_S * SAMPLE_RATE)
    with wave.open(path, 'w') as wf:
        wf.setnchannels(1)
        wf.setsampwidth(2)  # 16-bit
        wf.setframerate(SAMPLE_RATE)
        fade_len = int(0.02 * SAMPLE_RATE)
        for i in range(n):
            t = i / SAMPLE_RATE
            fade = 1.0
            if i < fade_len:
                fade = i / fade_len
            elif i > n - fade_len:
                fade = max(0.0, (n - i) / fade_len)
            sample = VOLUME * fade * math.sin(2 * math.pi * freq * t)
            wf.writeframes(struct.pack('<h', int(sample * 32767)))


def main():
    root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    for rel in OUT_DIRS:
        os.makedirs(os.path.join(root, rel), exist_ok=True)

    for fname, freq in SOUNDS:
        for rel in OUT_DIRS:
            out_path = os.path.join(root, rel, fname)
            write_beep(out_path, freq)
            print('wrote', out_path)


if __name__ == '__main__':
    main()
