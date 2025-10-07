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
