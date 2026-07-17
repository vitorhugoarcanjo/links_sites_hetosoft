from routes.modules.pasta_clientes import bp_clientes

def ini_imports_blueprints(app):
    app.register_blueprint(bp_clientes, url_prefix="/clientes")