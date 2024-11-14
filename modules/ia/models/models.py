from odoo import models, fields

class IAProcessing(models.Model):
    _name = 'ia.processing'
    _description = 'Procesamiento de IA para Imágenes y Audio'

    name = fields.Char(string="Nombre", required=True)
    content_type = fields.Selection([('audio', 'Audio'), ('image', 'Image')], string="Tipo de Contenido")
    image_description = fields.Text(string="Descripción de la Imagen")
