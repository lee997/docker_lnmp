from flask import Flask
from flask import request
from flask import jsonify
import json
import subprocess

app = Flask(__name__)
config = None

@app.route("/test")
def test():
    return jsonify(success=True), 200

@app.route("/hook", methods=['POST'])
def hook_listen():
    if request.method == 'POST':
        token = request.args.get('token')
        if token == config['token']:
            hook = request.args.get('hook')
            if hook:
                hook_value = config['hooks'].get(hook)
                if hook_value:
                    subprocess.Popen(hook_value, shell=True)
                    return jsonify(success=True), 200
                else:
                    return jsonify(success=False, error="Hook not found"), 404
            else:
                return jsonify(success=False, error="Invalid request: missing hook"), 400
        else:
            return jsonify(success=False, error="Invalid token"), 400

def load_config():
    with open('config.json') as config_file:
        return json.load(config_file)

if __name__ == "__main__":
    config = load_config()
    app.run(debug=True, host=config.get('host', '0.0.0.0'), port=config.get('port', 8000))
