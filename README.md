# FreeAI-endpoint
Portable zero-cost OpenAI-compatible API endpoint powered by Ollama and GitHub Codespaces.

# 🚀 FreeAI-endpoint

Turn any GitHub Codespace into a free, portable, OpenAI-compatible LLM API endpoint powered by Ollama.

## 📌 Features

- **Zero Cost**: Runs entirely on GitHub Codespaces free tier.
- **OpenAI Compatible**: Seamlessly works with official `openai` SDKs and standard API tools.
- **Multi-Model Catalog**: Pre-configured with lightweight coding, reasoning, and chat models.
- **AutoRoute Proxy**: Includes a local Python load-balancing proxy (`auto` model routing).
- **Automated Lifecycle**: Bash scripts for automated setup, model pulling, and cleanup.

---

## 🛠️ Quick Start Guide

### 1. Launch in Codespaces
1. Fork or open this repository in **GitHub Codespaces**.
2. Run the initialization script in the Codespace terminal:
   ```bash
   ./setup.sh
Copy the public URL generated at the end of the script output.2. Connect Your App (Windows / Local Machine)Use standard OpenAI client libraries pointing to your Codespace URL:Pythonfrom openai import OpenAI

client = OpenAI(
    base_url="[https://YOUR-CODESPACE-NAME-11434.app.github.dev/v1](https://YOUR-CODESPACE-NAME-11434.app.github.dev/v1)",
    api_key="ollama"
)

response = client.chat.completions.create(
    model="qwen2.5-coder:1.5b",
    messages=[{"role": "user", "content": "Write a Python function to check for prime numbers."}],
    stream=True
)

for chunk in response:
    content = chunk.choices[0].delta.content
    if content is not None:
        print(content, end="", flush=True)
🔀 AutoRoute Plugin (Local Load Balancer)To enable random load balancing with model="auto":Navigate to the AutoRoute-Plugin folder on your local machine.Install requirements:Bashpip install -r requirements.txt
Update CODESPACE_URL inside AutoRoute.py with your active URL.Run the local proxy:Bashpython AutoRoute.py
Point your applications to http://localhost:5000/v1 with model="auto".🛠️ Management ScriptsScriptAction./setup.shInstalls Ollama, exposes port 11434, and pulls default models../NewModels.shPulls custom models into your running instance../DeleteModel.shRemoves unused models to free up disk space.
