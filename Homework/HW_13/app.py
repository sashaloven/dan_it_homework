from flask import Flask, request, jsonify
import csv
import os

app = Flask(__name__)

def read_students():
    students = []
    with open('students.csv', 'r') as file:
        reader = csv.reader(file)
        try:
            next(reader)
            for row in reader:
                if len(row) >= 4:
                    students.append({'id': row[0], 'first_name': row[1], 'last_name': row[2], 'age': row[3]})
        except StopIteration:
            pass
    return students

def write_students(students):
    with open('students.csv', 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(['id', 'first_name', 'last_name', 'age'])
        for student in students:
            writer.writerow([student['id'], student['first_name'], student['last_name'], student['age']])

@app.route('/students', methods=['GET'])
def get_students():
    last_name = request.args.get('last_name')
    if last_name:
        students = [student for student in read_students() if student['last_name'] == last_name]
        if not students:
            return jsonify({'error': 'No students found with that last name'}), 404
    else:
        students = read_students()
    return jsonify(students)

@app.route('/students/<id>', methods=['GET'])
def get_student(id):
    students = read_students()
    for student in students:
        if student['id'] == id:
            return jsonify(student)
    return jsonify({'error': 'Student not found'}), 404

@app.route('/students', methods=['POST'])
def add_student():
    new_student = request.get_json()
    if not all(key in new_student for key in ('first_name', 'last_name', 'age')):
        return jsonify({'error': 'Missing fields in request body'}), 400
    students = read_students()
    new_id = str(int(students[-1]['id']) + 1) if students else '1'
    new_student['id'] = new_id
    students.append(new_student)
    write_students(students)
    return jsonify(new_student), 201

@app.route('/students/<id>', methods=['PUT'])
def update_student(id):
    updated_student = request.get_json()
    if not all(key in updated_student for key in ('id', 'first_name', 'last_name', 'age')):
        return jsonify({'error': 'Missing fields in request body'}), 400
    students = read_students()
    for i, student in enumerate(students):
        if student['id'] == id:
            students[i] = updated_student
            write_students(students)
            return jsonify(updated_student)
    return jsonify({'error': 'Student not found'}), 404

@app.route('/students/<id>', methods=['PATCH'])
def update_student_age(id):
    updated_age = request.get_json().get('age')
    if updated_age is None:
        return jsonify({'error': 'Missing age in request body'}), 400
    students = read_students()
    for i, student in enumerate(students):
        if student['id'] == id:
            students[i]['age'] = updated_age
            write_students(students)
            return jsonify(students[i])
    return jsonify({'error': 'Student not found'}), 404

@app.route('/students/<id>', methods=['DELETE'])
def delete_student(id):
    students = read_students()
    for i, student in enumerate(students):
        if student['id'] == id:
            del students[i]
            write_students(students)
            return jsonify({'result': 'Student deleted'})
    return jsonify({'error': 'Student not found'}), 404

if __name__ == '__main__':
    if not os.path.isfile('students.csv'):
        write_students([])
    app.run(debug=True)


