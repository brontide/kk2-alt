kk2-alt
=======

Here I will try to keep all source code changes to the KK2 firmware that I am working on.  There will be various branches based on conflicting sets of code.  I do not expect there to be downloadable .hex files for a while.

Hardware
======

<pre><code>
 ---------------------------
 |                  BUZZER  |
 |                  VOLT    |
 |    LED                   |
 | ALE/CPPM ----------  M1  |
 | ELE   |           |  M2  |
 | THR   |           |  M3  |
 | RUD   |           |  M4  |
 | AUX   |           |  M5  |
 |       |           |  M6  |
 |       |           |  M7  |
 | ISP   -------------  M8  |
 |       B1  B2  B3  B4     |
 ---------------------------
</code></pre>

- LED = b,3
- BUZZER = b,1
- M1 = c,6
- M2 = c,4
- M3 = c,2
- M4 = c,3
- M5 = c,1
- M6 = c,0
- M7 = c,5
- M8 = c,7
- ALE/CPPM/ROLL = d,3
- ELE/PITCH = d,2
- THR = d,0
- RUD/YAW = b,2
- AUX = b,0
- B1 = b,4 
- B2 = b,5
- B3 = b,6
- B4 = b,7
- VOLT = a,3
- GYRO Roll = a,1
- GYRO Pitch = a,4
- GYRO Yaw = a,2
- ACC X = a,5
- ACC Y = a,6
- ACC Z = a,7 

