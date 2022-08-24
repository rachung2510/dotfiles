#!/usr/bin/python3
import os
import struct
import subprocess
import tempfile
import numpy as np
import sys

BARS_NUMBER = 12
# OUTPUT_BIT_FORMAT = "8bit"
OUTPUT_BIT_FORMAT = "16bit"
# RAW_TARGET = "/tmp/cava.fifo"
RAW_TARGET = "/dev/stdout"

conpat = """
[general]
bars = %d
[output]
channels = mono
method = raw
raw_target = %s
bit_format = %s
"""

config = conpat % (BARS_NUMBER, RAW_TARGET, OUTPUT_BIT_FORMAT)
bytetype, bytesize, bytenorm = ("H", 2, 65535) if OUTPUT_BIT_FORMAT == "16bit" else ("B", 1, 255)


def run():
	with tempfile.NamedTemporaryFile() as config_file:
		config_file.write(config.encode())
		config_file.flush()

		process = subprocess.Popen(["cava", "-p", config_file.name], stdout=subprocess.PIPE)
		chunk = bytesize * BARS_NUMBER
		fmt = bytetype * BARS_NUMBER

		if RAW_TARGET != "/dev/stdout":
			if not os.path.exists(RAW_TARGET):
				os.mkfifo(RAW_TARGET)
			source = open(RAW_TARGET, "rb")
		else:
			source = process.stdout

		while True:
			try:
				data = source.read(chunk)
				if len(data) < chunk:
					break
				sample = np.array([i for i in struct.unpack(fmt, data)])  # raw values without norming
				# sample = [i / bytenorm for i in struct.unpack(fmt, data)]
				heights = sample / bytenorm * 100 + 3
				line = " ".join([str(int(x)) for x in heights])
				print(line)
				sys.stdout.flush()
			except KeyboardInterrupt:
				return

if __name__ == "__main__":
	run()

