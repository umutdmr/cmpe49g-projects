import random
import math

def buffon_needle_simulation(num_needles, needle_length, line_spacing):
    crosses_line = 0

    for _ in range(num_needles):
        # Randomly choose the midpoint of the needle
        x_midpoint = random.uniform(0, line_spacing / 2)
        
        # Randomly choose an angle (in radians) for the needle
        theta = random.uniform(0, 0.5 * math.pi)  # 0.5 * pi
        
        # Calculate the distance from the midpoint of the needle to the nearest line
        x_distance = (needle_length / 2) * math.sin(theta)
        
        # Check if the needle crosses a line
        if x_distance <= x_midpoint:
            crosses_line += 1

    # Estimate the probability of crossing a line
    probability = crosses_line / num_needles
    
    # Estimate π using the formula
    estimated_pi = (2 * needle_length) / (probability * line_spacing)
    
    return estimated_pi

# Set the simulation parameters
num_needles = 100000  # Number of needle drops
needle_length = 1.0    # Length of the needle
line_spacing = 2.0     # Spacing between the parallel lines

# Perform the simulation
estimated_pi = buffon_needle_simulation(num_needles, needle_length, line_spacing)

# Print the estimated value of π
print(f"Estimated π: {estimated_pi}")
