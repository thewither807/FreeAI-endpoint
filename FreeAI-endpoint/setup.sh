#!/bin/bash

echo "=========================================="
echo "   🚀 Starting FreeAI-endpoint"
echo "=========================================="

# 1. Install Ollama if not present
if ! command -v ollama &> /dev/null; then
    echo "📥 Installing Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
fi

# 2. Start Ollama server in background with public access
echo "🌐 Starting Ollama server in public mode..."
pkill ollama 2>/dev/null
export OLLAMA_HOST=0.0.0.0:11434
export OLLAMA_ORIGINS="*"
ollama serve > ollama.log 2>&1 &

# Wait for server initialization
sleep 3

# 3. Download model catalog
MODELS=(
    "qwen2.5:1.5b"
    "qwen2.5-coder:1.5b"
    "deepseek-r1:1.5b"
    "llama3.2:3b"
    "gemma2:2b"
    "codegemma:2b"
    "mistral:latest"
)

echo "📦 Pulling default models..."
for model in "${MODELS[@]}"; do
    echo "➜ Pulling $model..."
    ollama pull "$model"
done

# 4. Display connection details
CODESPACE_NAME=${CODESPACE_NAME:-"your-codespace"}
URL="https://${CODESPACE_NAME}-11434.app.github.dev/v1"

echo "=========================================="
echo "✅ FreeAI-endpoint is READY!"
echo "=========================================="
echo "🔗 Your OpenAI-compatible API URL:"
echo "   $URL"
echo ""
echo "💡 Usage example in Python:"
echo "------------------------------------------"
echo "from openai import OpenAI"
echo ""
echo "client = OpenAI("
echo "    base_url='$URL',"
echo "    api_key='ollama'"
echo ")"
echo "------------------------------------------"