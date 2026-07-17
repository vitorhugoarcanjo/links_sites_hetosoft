from flask import Blueprint, render_template

bp_clientes = Blueprint('clientes', __name__)

from .clientes import ini_clientes

bp_clientes.add_url_rule('/', view_func=ini_clientes, methods=['GET'])