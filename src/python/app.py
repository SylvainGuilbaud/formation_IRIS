from flask import Flask, jsonify, request, make_response
from grongier.pex import Director
import iris

from obj import Formation
from msg import FormationRequest


app = Flask(__name__)

# GET Infos
@app.route("/", methods=["GET"])
def get_info():
    info = {'version':'1.0.6'}
    return jsonify(info)

# GET all the formations
@app.route("/training/", methods=["GET"])
def get_all_training():
    payload = {}
    return jsonify(payload)

# POST a formation
@app.route("/training/", methods=["POST"])
def post_formation():
    payload = {} 

    formation = Formation()
    formation.nom = request.get_json()['nom']
    formation.salle = request.get_json()['salle']

    msg = FormationRequest(formation=formation)

    service = Director.CreateBusinessService("Python.FlaskService")
    response = service.dispatchProcessInput(msg)

    return jsonify(payload)

# GET formation with id
@app.route("/training/<int:id>", methods=["GET"])
def get_formation(id):
    payload = {}
    return jsonify(payload)

# PUT to update formation with id
@app.route("/training/<int:id>", methods=["PUT"])
def update_person(id):
    payload = {}
    return jsonify(payload)

# DELETE formation with id
@app.route("/training/<int:id>", methods=["DELETE"])
def delete_person(id):
    payload = {}  
    return jsonify(payload)

if __name__ == '__main__':
    app.run('0.0.0.0', port = "8081")