#!/bin/bash

echo "=========================================="
echo "   ➕ FreeAI-endpoint - Add a Model"
echo "=========================================="

# 1. Get model name from argument or user input
MODEL_NAME=$1

if [ -z "$MODEL_NAME" ]; then
    echo -n "👉 Enter Ollama model name (e.g., phi3:mini, tinydolphin, llama3:8b): "
    read MODEL_NAME
fi

if [ -z "$MODEL_NAME" ]; then
    echo "❌ No model name provided. Aborting."
    exit 1
fi

# 2. Pull the model
echo ""
echo "📥 Pulling '$MODEL_NAME' onto the server..."
ollama pull "$MODEL_NAME"

# 3. Check status
if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✅ Model '$MODEL_NAME' installed successfully!"
    echo "=========================================="
    echo "💡 You can now use it directly in your code:"
    echo ""
    echo "   response = client.chat.completions.create("
    echo "       model=\"$MODEL_NAME\","
    echo "       messages=[{\"role\": \"user\", \"content\": \"Hello!\"}]"
    echo "   )"
    echo "=========================================="
else
    echo ""
    echo "❌ Download failed. Check model spelling at https://ollama.com/library"
fi