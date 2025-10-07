from fastapi import FastAPI
from fastapi.responses import JSONResponse
app = FastAPI(
    title="Aura Scribe Service",
    description="Microservi�o respons�vel pela an�lise e processamento de logs.",
    version="0.1.0",
)
@app.get("/", tags=["Root"])
async def read_root():
    """Retorna uma mensagem de boas-vindas do servi�o."""
    return JSONResponse(content={"service": "Scribe-Logs", "status": "operacional"})
@app.get("/health", tags=["Health Check"])
async def health_check():
    """Verifica a sa�de do servi�o."""
    return JSONResponse(content={"status": "ok"})
