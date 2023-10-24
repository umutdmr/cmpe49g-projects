import matplotlib.pyplot as plt


# Sample data
x_values = [1, 2, 3, 4, 5]
y_values = [2, 4, 6, 8, 10]
label = "Linear Function"

# Create the plot
plt.plot(x_values, y_values, label=label, marker='o', linestyle='-')

# Add a horizontal line at y = 10
plt.axhline(y=10, color='red', linestyle='--', label='y = 10')

# Add labels and a title
plt.xlabel("X-axis")
plt.ylabel("Y-axis")
plt.title("Example Plot")

# Add a legend
plt.legend()

# Show the plot
plt.show()
