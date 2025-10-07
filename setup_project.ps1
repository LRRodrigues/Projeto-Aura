# ==============================================================================
# VERSÃO CORRIGIDA E DEFINITIVA - USE APENAS ESTE CÓDIGO
# Script de Setup do Projeto Aura (v3)
# ==============================================================================

Write-Host "Iniciando a configuração dos arquivos do Projeto Aura (v3 - Definitivo)..." -ForegroundColor Green

# --- Conteúdo dos Arquivos (usando blocos literais @'...'@ para evitar erros) ---

$readmeContent = @'
<p align="center">
  <img src="https://i.imgur.com/your-logo-here.png" alt="Aura Logo" width="150"/>
</p>
<h1 align="center">Projeto Aura</h1>
<p align="center">
  <em>Iluminando as Sombras do Ciberespaço</em>
</p>
<p align="center">
  <img alt="Status" src="https://img.shields.io/badge/status-em desenvolvimento-yellow">
  <img alt="Build" src="https://github.com/your-username/projeto-aura/actions/workflows/ci.yml/badge.svg">
  <img alt="Licença" src="https://img.shields.io/badge/licença-MIT-blue">
</p>
---
### 📖 Sobre o Projeto
**Aura** é uma plataforma de Inteligência de Cibersegurança de próxima geração, projetada para ser uma entidade proativa de defesa. Utilizando uma arquitetura de microserviços e um núcleo de Inteligência Artificial, Aura analisa dados de rede, logs e sistemas em tempo real para detectar, correlacionar e neutralizar ameaças antes que elas causem impacto.
### 🏛️ Arquitetura
O projeto é construído sobre uma arquitetura de microserviços moderna e escalável, orquestrada com Docker e preparada para Kubernetes. A comunicação é feita via APIs REST/gRPC e um message broker para garantir resiliência e desacoplamento.
### 🚀 Stack Tecnológica
| Camada       | Tecnologias Principais                               |
|--------------|------------------------------------------------------|
| **Backend** | Python (FastAPI), Go                                 |
| **Frontend** | React.js, D3.js, Material-UI                         |
| **IA/ML** | TensorFlow, PyTorch, Scikit-learn, Scapy             |
| **Dados** | Elasticsearch, PostgreSQL, Redis                     |
| **Infra** | Docker, Kubernetes, RabbitMQ, Nginx, GitHub Actions  |
### ⚡ Como Começar
**Pré-requisitos:**
* Docker
* Docker Compose
**Para iniciar o ambiente de desenvolvimento local:**
1.  Clone o repositório:
    `git clone https://github.com/your-username/projeto-aura.git`
    `cd projeto-aura`
2.  Inicie todos os serviços com Docker Compose:
    `docker-compose up --build`
3.  Acesse os serviços:
    * **Dashboard (Prism):** `http://localhost:3000`
    * **API Gateway:** `http://localhost:8000/docs`
### 🗺️ Roadmap do Projeto
- [x] **Fase 1: Fundação** - Estrutura base, CI/CD, serviço de captura de pacotes.
- [ ] **Fase 2: Inteligência Inicial** - Módulo de análise de logs e primeiro modelo de ML.
- [ ] **Fase 3: Expansão Forense** - Módulos de análise de memória e disco.
- [ ] **Fase 4: O Cérebro** - Core de inteligência, correlação e Threat Intelligence.
### 🤝 Contribuição
Contribuições são bem-vindas! Por favor, siga as diretrizes padrão de Fork e Pull Request.
### 📜 Licença
Distribuído sob a licença MIT.
'@

$dockerComposeContent = @'
version: '3.8'

services:
  # --- Backend Services ---
  api-gateway:
    build:
      context: ./backend/api-gateway
    ports:
      - "8000:8000"
    volumes:
      - ./backend/api-gateway/app:/app
    environment:
      - PYTHONUNBUFFERED=1
    networks:
      - aura-net

  scribe-logs:
    build:
      context: ./backend/scribe-logs
    volumes:
      - ./backend/scribe-logs/app:/app
    environment:
      - PYTHONUNBUFFERED=1
    networks:
      - aura-net
    depends_on:
      - rabbitmq

  sentinel-network:
    build:
      context: ./backend/sentinel-network
    networks:
      - aura-net

  # --- Frontend Service ---
  aura-prism-dashboard:
    build:
      context: ./frontend/aura-prism-dashboard
      dockerfile: Dockerfile
    ports:
      - "3000:80"
    networks:
      - aura-net
    depends_on:
      - api-gateway

  # --- Infrastructure Services ---
  postgres:
    image: postgres:14-alpine
    environment:
      - POSTGRES_USER=aura
      - POSTGRES_PASSWORD=supersecret
      - POSTGRES_DB=auradb
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - aura-net

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    networks:
      - aura-net

  rabbitmq:
    image: rabbitmq:3.9-management-alpine
    ports:
      - "5672:5672"  # AMQP
      - "15672:15672" # Management UI
    networks:
      - aura-net

# --- Volumes & Networks ---
volumes:
  postgres_data:

networks:
  aura-net:
    driver: bridge
'@

$gitignoreContent = @'
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST
*.manifest
*.spec
pip-log.txt
pip-delete-this-directory.txt
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
.hypothesis/
.pytest_cache/
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/
.idea/
.vscode/
node_modules/
npm-debug.log
yarn-error.log
.DS_Store
Thumbs.db
'@

$ciContent = @'
name: Aura CI | Build & Test
on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout repository
      uses: actions/checkout@v3
    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v2
    - name: Build all services with Docker Compose
      run: docker-compose build
    - name: Run placeholder for tests
      run: echo "Executando testes..." # TODO: Adicionar comandos de teste reais
'@

$apiGatewayDockerfile = @'
FROM python:3.10-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY ./app .
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
'@

$apiGatewayReqs = @'
fastapi==0.103.1
uvicorn[standard]==0.23.2
'@

$apiGatewayMain = @'
from fastapi import FastAPI
from fastapi.responses import JSONResponse
app = FastAPI(
    title="Aura API Gateway",
    description="Ponto de entrada único para a plataforma Aura.",
    version="0.1.0",
)
@app.get("/", tags=["Root"])
async def read_root():
    """Retorna uma mensagem de boas-vindas."""
    return JSONResponse(content={"message": "Aura API Gateway: Conectado e operando."})
@app.get("/health", tags=["Health Check"])
async def health_check():
    """Verifica a saúde do serviço."""
    return JSONResponse(content={"status": "ok"})
'@

$scribeLogsDockerfile = $apiGatewayDockerfile
$scribeLogsReqs = $apiGatewayReqs

$scribeLogsMain = @'
from fastapi import FastAPI
from fastapi.responses import JSONResponse
app = FastAPI(
    title="Aura Scribe Service",
    description="Microserviço responsável pela análise e processamento de logs.",
    version="0.1.0",
)
@app.get("/", tags=["Root"])
async def read_root():
    """Retorna uma mensagem de boas-vindas do serviço."""
    return JSONResponse(content={"service": "Scribe-Logs", "status": "operacional"})
@app.get("/health", tags=["Health Check"])
async def health_check():
    """Verifica a saúde do serviço."""
    return JSONResponse(content={"status": "ok"})
'@

$sentinelDockerfile = @'
# --- Estágio de Build ---
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o sentinel .
# --- Estágio Final ---
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/sentinel .
EXPOSE 8081
CMD ["./sentinel"]
'@

$sentinelGoMod = @'
module github.com/your-username/aura/sentinel
go 1.21
'@

$sentinelMainGo = @'
package main
import (
    "fmt"
    "log"
    "net/http"
)
func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Aura Sentinel Network Service: Ativo e monitorando.")
}
func main() {
    http.HandleFunc("/", handler)
    log.Println("Sentinel Service iniciado na porta 8081")
    log.Fatal(http.ListenAndServe(":8081", nil))
}
'@

$frontendDockerfile = @'
# --- Estágio de Build ---
FROM node:18-alpine AS builder
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build
# --- Estágio Final ---
FROM nginx:1.25-alpine
COPY --from=builder /app/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY ../../infrastructure/nginx/default.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
'@

$frontendPackageJson = @'
{
  "name": "aura-prism-dashboard",
  "version": "0.1.0",
  "private": true,
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-scripts": "5.0.1"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
  "browserslist": {
    "production": [ ">0.2%", "not dead", "not op_mini all" ],
    "development": [ "last 1 chrome version", "last 1 firefox version", "last 1 safari version" ]
  }
}
'@

$frontendAppJs = @'
import './App.css';
function App() {
  return (
    <div className="App">
      <header className="App-header">
        {/* <img src="/logo.svg" className="App-logo" alt="logo" /> */}
        <h1>Projeto Aura</h1>
        <p>Prism Dashboard</p>
        <span className="status">Status: <span className="status-ok">Conectado ao Gateway</span></span>
      </header>
    </div>
  );
}
export default App;
'@

$frontendAppCss = @'
body {
  background-color: #121212;
  color: white;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  margin: 0;
}
.App { text-align: center; }
.App-logo { height: 20vmin; pointer-events: none; }
.App-header {
  background-color: #1e1e1e;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  font-size: calc(10px + 2vmin);
}
.status { margin-top: 2rem; font-size: 0.8rem; color: #aaa; }
.status-ok { color: #4caf50; font-weight: bold; }
'@

$nginxConf = @'
server {
  listen 80;
  location / {
    root   /usr/share/nginx/html;
    index  index.html index.htm;
    try_files $uri $uri/ /index.html;
  }
}
'@

# --- Lógica de Criação de Arquivos ---
try {
    Set-Content -Path "README.md" -Value $readmeContent
    Set-Content -Path "docker-compose.yml" -Value $dockerComposeContent
    Set-Content -Path ".gitignore" -Value $gitignoreContent
    Write-Host "✓ Arquivos da raiz criados." -ForegroundColor Cyan
    Set-Content -Path ".github\workflows\ci.yml" -Value $ciContent
    Write-Host "✓ Arquivo de CI/CD criado." -ForegroundColor Cyan
    Set-Content -Path "backend\api-gateway\Dockerfile" -Value $apiGatewayDockerfile
    Set-Content -Path "backend\api-gateway\requirements.txt" -Value $apiGatewayReqs
    Set-Content -Path "backend\api-gateway\app\main.py" -Value $apiGatewayMain
    Write-Host "✓ Serviço Backend 'api-gateway' criado." -ForegroundColor Cyan
    Set-Content -Path "backend\scribe-logs\Dockerfile" -Value $scribeLogsDockerfile
    Set-Content -Path "backend\scribe-logs\requirements.txt" -Value $scribeLogsReqs
    Set-Content -Path "backend\scribe-logs\app\main.py" -Value $scribeLogsMain
    Write-Host "✓ Serviço Backend 'scribe-logs' criado." -ForegroundColor Cyan
    Set-Content -Path "backend\sentinel-network\Dockerfile" -Value $sentinelDockerfile
    Set-Content -Path "backend\sentinel-network\go.mod" -Value $sentinelGoMod
    Set-Content -Path "backend\sentinel-network\main.go" -Value $sentinelMainGo
    Write-Host "✓ Serviço Backend 'sentinel-network' criado." -ForegroundColor Cyan
    Set-Content -Path "frontend\aura-prism-dashboard\Dockerfile" -Value $frontendDockerfile
    Set-Content -Path "frontend\aura-prism-dashboard\package.json" -Value $frontendPackageJson
    Set-Content -Path "frontend\aura-prism-dashboard\src\App.js" -Value $frontendAppJs
    Set-Content -Path "frontend\aura-prism-dashboard\src\App.css" -Value $frontendAppCss
    Write-Host "✓ Serviço Frontend 'aura-prism-dashboard' criado." -ForegroundColor Cyan
    Set-Content -Path "infrastructure\nginx\default.conf" -Value $nginxConf
    Write-Host "✓ Arquivo de configuração Nginx criado." -ForegroundColor Cyan
    Write-Host "`nProjeto Aura estruturado com sucesso!" -ForegroundColor Green
    Write-Host "Todos os arquivos foram criados e preenchidos."
}
catch {
    Write-Host "`nOcorreu um erro:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
}