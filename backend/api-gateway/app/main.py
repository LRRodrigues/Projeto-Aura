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
