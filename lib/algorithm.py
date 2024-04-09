import folium
import googlemaps
from datetime import datetime
import random
import itertools

# Constants
DISCHARGING_RATE = 0.5  # Example discharging rate in km per minute

# Charging stations with their coordinates and properties
charging_stations = {
    'ABB Charging Station': {'location': [24.9601644, 66.8384994], 'availability': False, 'available_slots': 2, 'cost': 1.07, 'distance': 0, 'charging_speed': 36.14},
    'Electric Vehicle Charging Station': {'location': [24.8992013, 67.0959056], 'availability': True, 'available_slots': 1, 'cost': 2.78, 'distance': 0, 'charging_speed': 58.98},
    'Shell Recharge Charging Station': {'location': [24.8828, 67.0777], 'availability': True, 'available_slots': 3, 'cost': 4.97, 'distance': 0, 'charging_speed': 39.07},
    'BMW Charging Station': {'location': [24.9062234, 65.9905484], 'availability': False, 'available_slots': 1, 'cost': 2.28, 'distance': 0, 'charging_speed': 43.23},
    'EV Electric Car Chargers': {'location': [24.8962234, 66.9905484], 'availability': True, 'available_slots': 2, 'cost': 3.45, 'distance': 0, 'charging_speed': 45.03}
}

# Function to calculate distance between two points
def calculate_distance(point1, point2):
    return ((point1[0] - point2[0])**2 + (point1[1] - point2[1])**2)**0.5

# Function to calculate the remaining range of an EV
def calculate_remaining_range(battery_status):
    return battery_status / DISCHARGING_RATE

# Function to initialize charging stations and user's EV
def initialize_locations(google_maps_api_key):
    user_location = {'lat': random.uniform(24.8, 25), 'lng': random.uniform(66.8, 67.2)}
    user_battery_status = random.uniform(20, 80)  # Example initial battery status

    remaining_range = calculate_remaining_range(user_battery_status)

    return user_location, user_battery_status, remaining_range

# Function to get the route using Google Maps Directions API
def get_route(user_location, charging_station_location, google_maps_api_key):
    gmaps = googlemaps.Client(key=google_maps_api_key)

    # Specify the mode as 'driving' for cars; you can change it based on your use case
    waypoints = [tuple(charging_stations[cs]['location']) for cs in charging_station_location]
    directions_result = gmaps.directions(
        (user_location['lat'], user_location['lng']),
        (user_location['lat'], user_location['lng']),  # Destination set to user location to ensure the route starts and ends at the user's location
        mode="driving",
        departure_time=datetime.now(),
        waypoints=waypoints,
        optimize_waypoints=True
    )

    return directions_result

# Function to calculate fitness based on cost, distance, charging speed, and availability
def fitness(chromosome, charging_stations):
    total_cost = 0
    total_distance = 0
    total_charging_speed = 0
    availability_penalty = 0  # Initialize availability penalty
    max_available_slots = 0  # Initialize maximum available slots

    for cs in chromosome:
        properties = charging_stations[cs]
        # Omit charging stations with availability set to False or available slots of 0
        if not properties['availability'] or properties['available_slots'] == 0:
            availability_penalty += 1000  # A high penalty to strongly discourage selecting unavailable stations
        else:
            total_cost += properties['cost']
            total_distance += properties['distance']
            total_charging_speed += properties['charging_speed']

            # Update max_available_slots if the current charging station has more slots
            max_available_slots = max(max_available_slots, properties['available_slots'])

    # Define weights for each parameter (you can adjust these)
    cost_weight = 0.4
    distance_weight = 0.3
    charging_speed_weight = 0.2
    availability_weight = 0.1

    # Apply a bonus for the charging station with the maximum available slots
    max_available_slots_bonus = 100
    if max_available_slots > 0:
        availability_penalty -= max_available_slots_bonus

    # Calculate total fitness using weighted combination of parameters
    total_fitness = -(cost_weight * total_cost +
                      distance_weight * total_distance +
                      charging_speed_weight * total_charging_speed -
                      availability_weight * availability_penalty)

    return total_fitness

# Genetic Algorithm functions
def initialize_population(charging_stations):
    return list(itertools.permutations(charging_stations.keys()))

def crossover(parent1, parent2):
    split_point = random.randint(1, len(parent1) - 1)
    child1 = parent1[:split_point] + parent2[split_point:]
    child2 = parent2[:split_point] + parent1[split_point:]
    return child1, child2

def mutate(chromosome):
    mutated_chromosome = list(chromosome)
    idx1, idx2 = random.sample(range(len(chromosome)), 2)
    mutated_chromosome[idx1], mutated_chromosome[idx2] = mutated_chromosome[idx2], mutated_chromosome[idx1]
    return tuple(mutated_chromosome)

def select_parents(population):
    return random.sample(population, 2)

def genetic_algorithm(charging_stations):
    population = list(set(initialize_population(charging_stations)))

    for generation in range(100):
        new_population = []

        for _ in range(100):
            parent1, parent2 = select_parents(population)
            child1, child2 = crossover(parent1, parent2)
            child1 = mutate(child1)
            child2 = mutate(child2)
            new_population.extend([child1, child2])

        population = list(set(new_population))

    # Select the best solution from the final population
    best_solution = max(population, key=lambda x: fitness(x, charging_stations))
    return best_solution

def visualize_map(user_location, user_battery_status, remaining_range, best_solution, charging_stations, google_maps_api_key):
    # Create a folium map centered at the user's location
    map_center = [user_location['lat'], user_location['lng']]
    my_map = folium.Map(location=map_center, zoom_start=12)

    # Add user's EV marker to the map with remaining range information
    popup_text_user = f"User's EV<br>Remaining Battery: {user_battery_status}%<br>Remaining Range: {remaining_range:.2f} km"
    folium.Marker(location=(user_location['lat'], user_location['lng']), popup=popup_text_user, icon=folium.Icon(color='blue')).add_to(my_map)

    # Add charging station markers with popup information
    for cs, properties in charging_stations.items():
        color = 'green' if properties['availability'] and properties['available_slots'] > 0 else 'gray'
        popup_text = f"{cs}<br>Location: {properties['location'][0]}, {properties['location'][1]}<br>Cost: {properties['cost']}<br>Charging Speed: {properties['charging_speed']}<br>Available Slots: {properties['available_slots']}"
        folium.Marker(location=properties['location'], popup=popup_text, icon=folium.Icon(color=color)).add_to(my_map)

    # Add edge between user's EV and the best charging station
    best_cs_location = charging_stations[best_solution[0]]['location']
    route = get_route(user_location, best_solution, google_maps_api_key)

    if route:
        coordinates = [(step['start_location']['lat'], step['start_location']['lng']) for step in route[0]['legs'][0]['steps']]
        coordinates.append((route[0]['legs'][0]['steps'][-1]['end_location']['lat'], route[0]['legs'][0]['steps'][-1]['end_location']['lng']))
        folium.PolyLine(locations=coordinates, color="green").add_to(my_map)

    # Save the map as an HTML file
    my_map.save("charging_station_assignment_map.html")

    print("Interactive map saved as charging_station_assignment_map.html")

# Main program
google_maps_api_key = 'AIzaSyBeG5g3Ps44SleGRirPm4IcnC9BvwbLqDI'  # Replace with your actual Google Maps API key

user_location, user_battery_status, remaining_range = initialize_locations(google_maps_api_key)

print("User's EV Location:", user_location)
print("User's Battery Status:", user_battery_status)
print("Remaining Range:", remaining_range)

best_solution = genetic_algorithm(charging_stations)
print("\nBest Charging Station Assignment:", best_solution)

visualize_map(user_location, user_battery_status, remaining_range, best_solution, charging_stations, google_maps_api_key)
