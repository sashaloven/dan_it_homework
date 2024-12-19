import requests
import json

BASE_URL = "http://127.0.0.1:5000/students"

def print_response(response):
    print(f"Status Code: {response.status_code}")
    print("Response JSON:")
    print(json.dumps(response.json(), indent=4))

def save_results_to_file(content):
    with open('results.txt', 'a') as f:
        f.write(content + '\n\n')

def test_api():
    # Step 1: Retrieve all existing students (GET)
    response = requests.get(BASE_URL)
    print("GET all students:")
    print_response(response)
    save_results_to_file(f"GET all students:\n{response.text}")

    # Step 2: Create three students (POST)
    students = [
        {"first_name": "John", "last_name": "Doe", "age": 20},
        {"first_name": "Jane", "last_name": "Doe", "age": 21},
        {"first_name": "Jim", "last_name": "Beam", "age": 22}
    ]

    for i, student in enumerate(students):
        response = requests.post(BASE_URL, json=student)
        print(f"POST student {i+1}:")
        print_response(response)
        save_results_to_file(f"POST student {i+1}:\n{response.text}")

    # Step 3: Retrieve information about all existing students (GET)
    response = requests.get(BASE_URL)
    print("GET all students after adding three students:")
    print_response(response)
    save_results_to_file(f"GET all students after adding three students:\n{response.text}")

    # Step 4: Update the age of the second student (PATCH)
    second_student_id = '2'
    response = requests.patch(f"{BASE_URL}/{second_student_id}", json={"age": 23})
    print("PATCH update age of second student:")
    print_response(response)
    save_results_to_file(f"PATCH update age of second student:\n{response.text}")

    # Step 5: Retrieve information about the second student (GET)
    response = requests.get(f"{BASE_URL}/{second_student_id}")
    print("GET second student after age update:")
    print_response(response)
    save_results_to_file(f"GET second student after age update:\n{response.text}")

    # Step 6: Update the first name, last name, and age of the third student (PUT)
    third_student_id = '3'
    updated_data = {
        "id": third_student_id,
        "first_name": "Jimmy",
        "last_name": "Bourbon",
        "age": 24
    }
    response = requests.put(f"{BASE_URL}/{third_student_id}", json=updated_data)
    print("PUT update third student:")
    print_response(response)
    save_results_to_file(f"PUT update third student:\n{response.text}")

    # Step 7: Retrieve information about the third student (GET)
    response = requests.get(f"{BASE_URL}/{third_student_id}")
    print("GET third student after update:")
    print_response(response)
    save_results_to_file(f"GET third student after update:\n{response.text}")

    # Step 8: Retrieve all existing students (GET)
    response = requests.get(BASE_URL)
    print("GET all students after all updates:")
    print_response(response)
    save_results_to_file(f"GET all students after all updates:\n{response.text}")

    # Step 9: Delete the first student (DELETE)
    first_student_id = '1'
    response = requests.delete(f"{BASE_URL}/{first_student_id}")
    print("DELETE first student:")
    print_response(response)
    save_results_to_file(f"DELETE first student:\n{response.text}")

    # Step 10: Retrieve all existing students (GET)
    response = requests.get(BASE_URL)
    print("GET all students after deletion:")
    print_response(response)
    save_results_to_file(f"GET all students after deletion:\n{response.text}")

if __name__ == "__main__":
    test_api()
