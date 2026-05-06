#!/bin/usr/env python

import matplotlib.pyplot as plt
import pandas as pd
import sys
from scipy.optimize import curve_fit
import numpy as np

deg = "Celsius"

def cooling(t, T_s, T_0, k):
	return T_s - (T_0-T_s)*np.exp(-k*t)
ks =[]
k_err = []
f, ax = plt.subplots()
for ip in range(1,6):
	file = f"temp_log_{ip}.txt"
	df = pd.read_csv(file)

	t = df["Time"]
	t0 = t[0]
	t = t - t0
	temp = df["temp"]
	
	popt, pcov = curve_fit(cooling,t,temp)

	ax.plot(t,temp, label=f'Cooling Curve {ip}')
	ax.plot(t,cooling(t, *popt), '--r')
	ks.append(popt[2])
	k_err.append(np.sqrt(np.diag(pcov)[2]))

ax.set_xlabel("Time (s)")
ax.set_ylabel(f"Degrees {deg}")
ax.set_title("Temperature over time")
ax.legend()
plt.savefig("Temp_plot.png")
plt.show()

print('values of cooling constants are:', *np.round(ks, 3))
print('uncertainties of coooling constants are:', *np.round(k_err, 4))
# print(t[1], cpu[-1])
