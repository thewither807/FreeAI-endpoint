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
