from flask import Flask, render_template

app = Flask(__name__)


@app.route('/')
def ini_app():
    return render_template('pasta_inicio/inicio.html')


if __name__ == '__main__':
    app.run(debug=True, port=5009)