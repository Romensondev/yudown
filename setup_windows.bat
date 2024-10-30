@echo off

:: Crear y activar un entorno virtual (opcional)
python -m venv venv
call venv\Scripts\activate.bat

:: Instalar las dependencias
pip install -r requirements.txt

:: Crear el directorio de descargas si no existe
mkdir downloads

echo Dependencias instaladas y entorno configurado.
