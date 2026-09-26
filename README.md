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
   ```
3. Copy the public URL generated at the end of the script output.

---

### 2. Connect Your App (Windows / Local Machine)

Use standard OpenAI client libraries pointing to your Codespace URL:

```python
from openai import OpenAI

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

print()
```

---

## 🔀 AutoRoute Plugin (Local Load Balancer)

To enable random load balancing with `model="auto"`:

1. Navigate to the `AutoRoute-Plugin` folder on your local machine.
2. Install requirements:
   ```bash
   pip install -r requirements.txt
   ```
3. Update `CODESPACE_URL` inside `AutoRoute.py` with your active URL.
4. Run the local proxy:
   ```bash
   python AutoRoute.py
   ```
5. Point your applications to `http://localhost:5000/v1` with `model="auto"`.

---

## 🛠️ Management Scripts

| Script | Action |
| :--- | :--- |
| `./setup.sh` | Installs Ollama, exposes port 11434, and pulls default models. |
| `./NewModels.sh` | Pulls custom models into your running instance. |
| `./DeleteModel.sh` | Removes unused models to free up disk space. |
