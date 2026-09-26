#!/bin/bash

echo "=========================================="
echo "   🗑️  FreeAI-endpoint - Delete a Model"
echo "=========================================="

# 1. Ensure Ollama service is running
if ! pgrep -x "ollama" > /dev/null; then
    echo "⚠️  Ollama server is not running."
    echo "Starting temporary service to list models..."
    export OLLAMA_HOST=0.0.0.0:11434
    export OLLAMA_ORIGINS="*"
    ollama serve > /dev/null 2>&1 &
    sleep 2
fi

# 2. List currently installed models
echo "📋 Currently installed models on server:"
echo "--------------------------------------------------"
ollama list
echo "--------------------------------------------------"

# 3. Get model name from argument or user input
MODEL_NAME=$1

if [ -z "$MODEL_NAME" ]; then
    echo ""
    echo -n "👉 Enter exact model name to delete (e.g., mistral:latest): "
    read MODEL_NAME
fi

if [ -z "$MODEL_NAME" ]; then
    echo "❌ No model name provided. Aborting."
    exit 1
fi

# 4. Request confirmation
echo ""
read -p "❓ Are you sure you want to delete '$MODEL_NAME'? (y/N): " CONFIRMATION
if [[ "$CONFIRMATION" != "y" && "$CONFIRMATION" != "Y" ]]; then
    echo "❌ Deletion canceled."
    exit 0
fi

# 5. Remove model
echo ""
echo "🗑️  Deleting '$MODEL_NAME'..."
ollama rm "$MODEL_NAME"

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✅ Model '$MODEL_NAME' deleted successfully!"
    echo "💾 Disk space and memory freed."
    echo "=========================================="
else
    echo ""
    echo "❌ Deletion failed. Verify the model name using 'ollama list'."
fi