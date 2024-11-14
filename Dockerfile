# Usa la imagen base de Odoo versión 17
FROM odoo:17.0

# Actualiza e instala las dependencias necesarias del sistema
RUN apt-get update && apt-get install -y \
    python3-pip \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libsasl2-dev \
    libldap2-dev \
    libjpeg-dev \
    libpq-dev \
    libssl-dev \
    libffi-dev \
    libblas-dev \
    libatlas-base-dev \
    ffmpeg && apt-get clean

# Actualiza pip e instala las dependencias de Python necesarias
RUN pip3 install --upgrade pip
RUN pip3 install cloudinary pyjwt python-dotenv cohere

# Instala whisper de OpenAI y las dependencias desde el repositorio
RUN pip3 install -U openai-whisper
RUN pip3 install git+https://github.com/openai/whisper.git

# Copia el archivo de configuración personalizado de Odoo
COPY ./config_odoo/odoo.conf /etc/odoo/odoo.conf

# Copia los módulos personalizados a la carpeta de addons
COPY ./modules /mnt/extra-addons

# Crea una carpeta para los logs de Odoo y ajusta los permisos
RUN mkdir -p /var/log/odoo && chown -R odoo: /var/log/odoo

# Define variables de entorno necesarias
ENV HOST=db
ENV USER=odoo
ENV PASSWORD=myodootest

# Exponer el puerto de Odoo
EXPOSE 8069

# Comando para iniciar Odoo
CMD ["odoo"]
