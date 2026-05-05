#!/bin/usr/env python

import matplotlib.pyplot as plt
import pandas as pd
import sys

file = sys.argv[1]
deg = sys.argv[2]
deg = deg[1]
df = pd.read_csv(file)

t = df["Time"]
t0 = t[0]
t = t - t0
temp = df["temp"]

f, ax = plt.subplots()
ax.plot(t,temp,'k')
ax.set_xlabel("Time (s)")
ax.set_ylabel(f"Degrees {deg}")
ax.set_title(f"Temperature over time, initialized at {t0}")
plt.savefig("Temp_plot.png")

# print(t[1], cpu[-1])
