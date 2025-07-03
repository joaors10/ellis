# Etapa 1: Usar uma imagem base oficial do Python
# Usar uma imagem 'slim' é uma boa prática para manter o tamanho da imagem final menor.
FROM python:3.13.4-alpine

# Etapa 2: Definir o diretório de trabalho no contêiner
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências para o diretório de trabalho
# Isso é feito primeiro para aproveitar o cache de camadas do Docker.
COPY requirements.txt .

# Etapa 4: Instalar as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada
EXPOSE 8000

# Etapa 7: Comando para iniciar a aplicação usando Uvicorn
# O host 0.0.0.0 torna a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"] 