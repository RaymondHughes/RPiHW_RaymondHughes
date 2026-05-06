#!/bin/usr/env python

import matplotlib.pyplot as plt
import pandas as pd
import sys

file = sys.argv[1]
df = pd.read_csv(file)

t = df["Time"]
t0 = t[0]
t = t - t0
solar = df["solar"]

f, ax = plt.subplots()
ax.plot(t,solar,'k')
ax.set_xlabel("Time (s)")
ax.set_ylabel(f"Voltage of Solar Cell")
ax.set_title(f"Solar Cell Voltage over time, initialized at {t0}")
plt.savefig("Solar_plot.png")

# print(t[1], cpu[-1])
