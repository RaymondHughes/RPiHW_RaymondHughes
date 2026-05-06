#!/bin/usr/env python

import matplotlib.pyplot as plt
import pandas as pd
import sys
from numpy.fft import fft, ifft, ifftshift, fftfreq
import numpy as np

dts = [.1,.01,.001]
for i in range(3):
    dt = dts[i]
    sample_rate = int(1/dt)
    file = f"solar_log_{i+1}.txt"
    
    df = pd.read_csv(file)

    t = df["Time"]
    t_proper = np.linspace(0, 1, sample_rate, endpoint=False)
    t0 = t[0]
    t = t - t0
    solar = df["solar"]
    signal = solar

    ### I ran out of time so I am using the FFT code from the github
    
    # Compute FFT
    fft_result = fft(signal)
    magnitude = abs(fft_result)          # Complex → magnitude
    freqs = fftfreq(len(signal), d=1/sample_rate)  # Frequency axis in Hz

    # Keep only positive frequencies (the spectrum is mirrored)
    pos_mask = freqs >= 0
    freqs = freqs[pos_mask]
    magnitude = magnitude[pos_mask]

    # Normalize
    magnitude = magnitude / len(signal)     # Scale by N

    # Plot
    plt.figure(figsize=(10, 4))
    plt.plot(freqs, magnitude)
    plt.xlabel("Frequency (Hz)")
    plt.ylabel("Magnitude")
    plt.title("FFT Magnitude Spectrum")
    plt.grid(True)
    plt.tight_layout()
    plt.show()
    f, ax = plt.subplots()
    ax.plot(t,solar,'k')
    ax.set_xlabel("Time (s)")
