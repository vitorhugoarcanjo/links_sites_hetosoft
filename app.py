from flask import Flask, render_template
from config.import_blueprints import ini_imports_blueprints

app = Flask(__name__)

# imports de blueprints
ini_imports_blueprints(app)

@app.route('/')
def ini_app():
    return render_template('pasta_inicio/inicio.html')


if __name__ == '__main__':
    app.run(debug=True, port=5009)