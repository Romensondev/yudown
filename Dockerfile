# Use a imagem Debian como base
FROM debian:latest

# Instale as dependências do sistema e o Python
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    apt-get clean

# Defina o diretório de trabalho no contêiner
WORKDIR /app

# Crie um ambiente virtual
RUN python3 -m venv /app/venv

# Ative o ambiente virtual e instale as dependências do Python
COPY requirements.txt requirements.txt
RUN /app/venv/bin/pip install -r requirements.txt

# Copie todos os arquivos da aplicação para o diretório de trabalho
COPY . .

# Exponha a porta em que o Flask irá rodar
EXPOSE 5000

# Comando para iniciar a aplicação
CMD ["/app/venv/bin/python", "app.py"]
