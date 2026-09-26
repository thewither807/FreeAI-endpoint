import random
import requests
from flask import Flask, request, Response

app = Flask(__name__)

# 🔗 Replace with your active GitHub Codespace API URL
CODESPACE_URL = "Your_Codespace_API_URL_here"

# Catalog of available models on your server
AVAILABLE_MODELS = [
    "qwen2.5:1.5b",
    "qwen2.5-coder:1.5b",
    "deepseek-r1:1.5b",
    "llama3.2:3b",
    "gemma2:2b",
    "codegemma:2b",
    "mistral:latest"
]

@app.route('/v1/chat/completions', methods=['POST'])
def chat_completions():
    data = request.get_json()
    
    # If model is set to "auto", pick a random model from the list
    if data.get("model") == "auto":
        chosen_model = random.choice(AVAILABLE_MODELS)
        data["model"] = chosen_model
        print(f"🔀 [AutoRoute] Redirected 'auto' -> {chosen_model}")

    # Forward the request to the Codespace API endpoint
    try:
        res = requests.post(
            f"{CODESPACE_URL}/chat/completions",
            json=data,
            headers={"Authorization": request.headers.get("Authorization", "Bearer ollama")},
            stream=True
        )

        # Stream the response back to the client
        return Response(
            res.iter_content(chunk_size=1024),
            status=res.status_code,
            content_type=res.headers.get('content-type')
        )
    except Exception as e:
        print(f"❌ [AutoRoute] Error connecting to Codespace: {e}")
        return {"error": "Failed to reach target server"}, 500

@app.route('/v1/models', methods=['GET'])
def get_models():
    """Fetch model list from Codespace and append the virtual 'auto' model."""
    try:
        res = requests.get(f"{CODESPACE_URL}/models")
        data = res.json()
        data["data"].append({"id": "auto", "object": "model", "owned_by": "autoroute"})
        return data
    except Exception as e:
        print(f"❌ [AutoRoute] Error fetching models: {e}")
        return {"error": "Failed to fetch model list"}, 500

if __name__ == "__main__":
    print("==========================================")
    print("🚀 AutoRoute Proxy active on http://localhost:5000/v1")
    print("==========================================")
    app.run(host="0.0.0.0", port=5000)