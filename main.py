import random
import math

L = 10
D = 15

num_of_samples = 100000


"""for _ in range(num_of_samples):
    num_of_lands = 0
    x = random.uniform(0, D / 2)
    theta = random.uniform(0, 90)
    sinus = math.sin(math.radians(theta))
    if x <= (L / 2) * sinus:
        num_of_lands += 1

print(1 / (((num_of_lands / num_of_samples) * D) / (2 * L)))"""


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
    
#pi_estimate = buffons_needle(L, D, num_of_samples)
#print(f"Estimated π: {pi_estimate}")

pi_results = []
sample_list = [100, 1000, 10000, 100000, 1000000]

for sample in sample_list:
    pi_res = buffons_needle(L, D, sample)
    pi_results.append(pi_res)
    
print(f"Estimated π values: {pi_results}")