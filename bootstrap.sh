echo "🚀 Starting ConjureCart bootstrap..."

detect_os() {
    case "$(uname -s)" in
        Darwin*)    OS="mac";;
        MINGW*)     OS="windows";;
        CYGWIN*)    OS="windows";;
        MSYS*)      OS="windows";;
        Linux*)     OS="linux";;
        *)          OS="unknown";;
    esac
}

install_dependencies() {
    case $OS in
        "linux")
            sudo apt-get update
            sudo apt-get install -y build-essential git curl
            ;;
        "mac")
            echo "📦 Installing dependencies via Homebrew"
            if ! command -v brew &> /dev/null; then
                echo "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            brew install git curl
            ;;
        "windows")
            echo "📦 Windows detected"
            ;;
    esac
}

install_uv() {
    if command -v uv &> /dev/null; then
        echo "✅ uv is already installed ($(uv --version))"
    else
        echo "Installing uv..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
        
        case $OS in
            "windows")
                export PATH="$HOME/.cargo/bin:$PATH"
                ;;
            *)
                export PATH="$HOME/.cargo/bin:$PATH"
                ;;
        esac
    fi
}

detect_os
install_dependencies
install_uv
echo "🔄 Syncing dependencies..."
uv sync
case $OS in
    "windows")
        source .venv/Scripts/activate
        ;;
    *)
        source .venv/bin/activate
        ;;
esac