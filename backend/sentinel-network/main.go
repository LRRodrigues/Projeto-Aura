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
