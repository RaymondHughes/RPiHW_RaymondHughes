import time
import board
import adafruit_mcp9808
import sys

# Initialize I2C bus and sensor
i2c = board.I2C() 
mcp = adafruit_mcp9808.MCP9808(i2c)

# Celcius or Farenheit
if (sys.argv[1] == "C") or (sys.argv[1] == 'c'):
    cels = True
elif (sys.argv[1] == "F") or (sys.argv[1] == 'f'):
    cels = False
else:
    cels = True

t = time.time()
tempC = mcp.temperature
tempF = tempC * 9 / 5 + 32
if cels:
    print(f"{t},{tempC:.2f}")
else:
    print(f"{t},{tempF:.2f}")
