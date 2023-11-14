import random
import math
import matplotlib.pyplot as plt

l_values = [10, 20, 30]
d_values = [12, 30, 75]
sample_list = [100, 1000, 10000, 100000, 1000000]
PI = math.pi


def buffons_needle(L, D, samples):

    lands = 0
    for _ in range(samples):
        
        x = random.uniform(0, D / 2)
        theta = math.radians(random.uniform(0, 90))
        sinus = math.sin(theta)
        if x <= (L / 2) * sinus:
            lands += 1
    pi_res = 1 / (((lands / samples) * D) / (2 * L))
    return pi_res
    

pi_results = []

for i in range(len(l_values)):
    
    pi_result = []
    
    for sample in sample_list:
        
        pi_res = buffons_needle(l_values[i], d_values[i], sample)
        pi_result.append(pi_res)
        
    pi_results.append(pi_result)
    
for j in range(len(pi_results)):
    
    
    x_values = sample_list
    y_values = pi_results[j]
    
    print(f"Estimated π values: {y_values}")
    
    label = "pi results"
    
    plt.plot(x_values, y_values, label=label, marker='o', linestyle='-')
    
    plt.axhline(y=PI, color='red', linestyle='--', label='y = pi')


    plt.xlabel("X-axis")
    plt.ylabel("Y-axis")
    plt.title(f"Estimated pi value for L value {l_values[j]} and D value {d_values[j]}")

    plt.legend()
    plt.show()
    