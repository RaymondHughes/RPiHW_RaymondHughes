#!/bin/usr/env python

import matplotlib.pyplot as plt
import pandas as pd
import sys

file = sys.argv[1]
df = pd.read_csv(file)

t = df["Time"]
t0 = t[0]
t = t - t0
cpu = df["cpu"]

f, ax = plt.subplots()
ax.plot(t, cpu,'k')
ax.set_xlabel("Time (s)")
ax.set_ylabel("% CPU usage")
ax.set_title(f"CPU usage over time, initialized at {t0}")
plt.savefig("CPU_plot.png")

# print(t[1], cpu[-1])