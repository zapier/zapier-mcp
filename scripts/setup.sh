#!/bin/bash
set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Zapier MCP Setup${NC}"
echo ""

# Check for jq
if ! command -v jq &> /dev/null; then
    echo -e "${YELLOW}⚠️  jq is not installed${NC}"
    echo ""
    echo "jq is required for the build system."
    echo ""
    echo "Install it with:"
    echo "  macOS:        brew install jq"
    echo "  Ubuntu/Debian: sudo apt-get install jq"
    echo "  CentOS/RHEL:   sudo yum install jq"
    echo ""
    exit 1
fi

echo -e "${GREEN}✓${NC} jq is installed"

# Check for make
if ! command -v make &> /dev/null; then
    echo -e "${RED}✗${NC} make is not installed"
    echo ""
    echo "make is required for the build system."
    echo "Please install make for your system."
    exit 1
fi

echo -e "${GREEN}✓${NC} make is installed"

# Check for fswatch (optional)
if command -v fswatch &> /dev/null; then
    echo -e "${GREEN}✓${NC} fswatch is installed (optional, for watch mode)"
else
    echo -e "${YELLOW}○${NC} fswatch not installed (optional, for watch mode)"
    echo "  Install with: brew install fswatch"
fi

echo ""
echo -e "${BLUE}Building all plugins...${NC}"
make build-all

echo ""
echo -e "${GREEN}✓ Setup complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Review the plugins in ./plugins/"
echo "  2. Read BUILD.md for build system documentation"
echo "  3. Read CONTRIBUTING.md for development guidelines"
echo ""
echo "Common commands:"
echo "  make help              - Show all available commands"
echo "  make build-all         - Rebuild all plugins"
echo "  make list-plugins      - List available plugins"
echo ""

