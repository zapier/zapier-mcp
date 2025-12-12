.PHONY: help build build-all clean clean-all list-plugins zip-skills

# Colors for output
GREEN  := \033[0;32m
YELLOW := \033[0;33m
BLUE   := \033[0;34m
NC     := \033[0m # No Color

# Directories
ROOT_DIR := $(shell pwd)
SKILLS_DIR := $(ROOT_DIR)/skills
COMMANDS_DIR := $(ROOT_DIR)/commands
PLUGINS_DIR := $(ROOT_DIR)/plugins
DIST_DIR := $(ROOT_DIR)/dist

help: ## Show this help message
	@echo "$(BLUE)Available targets:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-15s$(NC) %s\n", $$1, $$2}'

list-plugins: ## List all available plugins
	@echo "$(BLUE)Available plugins:$(NC)"
	@for plugin_file in $(PLUGINS_DIR)/*.json; do \
		if [ -f "$$plugin_file" ]; then \
			plugin_name=$$(basename "$$plugin_file" .json); \
			echo "  $(GREEN)✓$(NC) $$plugin_name"; \
		fi; \
	done

build: ## Build a specific plugin (usage: make build PLUGIN=zapier-eng-plugin)
ifndef PLUGIN
	@echo "$(YELLOW)Error: PLUGIN not specified$(NC)"
	@echo "Usage: make build PLUGIN=plugin-name"
	@echo "Example: make build PLUGIN=zapier-eng-plugin"
	@exit 1
endif
	@$(MAKE) build-plugin PLUGIN=$(PLUGIN)

build-all: ## Build all plugins
	@echo "$(BLUE)Building all plugins...$(NC)"
	@for plugin_file in $(PLUGINS_DIR)/*.json; do \
		if [ -f "$$plugin_file" ]; then \
			plugin_name=$$(basename "$$plugin_file" .json); \
			echo "$(BLUE)Building $$plugin_name...$(NC)"; \
			$(MAKE) build-plugin PLUGIN=$$plugin_name; \
		fi; \
	done
	@echo "$(GREEN)✓ All plugins built successfully!$(NC)"

build-plugin:
	@if [ ! -f "$(PLUGINS_DIR)/$(PLUGIN).json" ]; then \
		echo "$(YELLOW)Error: $(PLUGIN).json not found in $(PLUGINS_DIR)$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Building $(PLUGIN)...$(NC)"
	
	# Create output directory structure
	@mkdir -p "$(DIST_DIR)/plugins/$(PLUGIN)/skills"
	@mkdir -p "$(DIST_DIR)/plugins/$(PLUGIN)/commands"
	@mkdir -p "$(DIST_DIR)/plugins/$(PLUGIN)/.claude-plugin"
	
	# Copy skills
	@echo "  Copying skills..."
	@skills=$$(jq -r '.skills[]?' "$(PLUGINS_DIR)/$(PLUGIN).json"); \
	for skill in $$skills; do \
		if [ -d "$(SKILLS_DIR)/$$skill" ]; then \
			echo "    $(GREEN)✓$(NC) $$skill"; \
			cp -r "$(SKILLS_DIR)/$$skill" "$(DIST_DIR)/plugins/$(PLUGIN)/skills/"; \
		else \
			echo "    $(YELLOW)✗$(NC) $$skill (not found)"; \
		fi; \
	done
	
	# Copy commands
	@echo "  Copying commands..."
	@commands=$$(jq -r '.commands[]?' "$(PLUGINS_DIR)/$(PLUGIN).json"); \
	for cmd in $$commands; do \
		if [ -f "$(COMMANDS_DIR)/$$cmd.md" ]; then \
			echo "    $(GREEN)✓$(NC) $$cmd"; \
			mkdir -p "$$(dirname "$(DIST_DIR)/plugins/$(PLUGIN)/commands/$$cmd.md")"; \
			cp "$(COMMANDS_DIR)/$$cmd.md" "$(DIST_DIR)/plugins/$(PLUGIN)/commands/$$cmd.md"; \
		else \
			echo "    $(YELLOW)✗$(NC) $$cmd (not found)"; \
		fi; \
	done
	
	# Generate .mcp.json
	@echo "  Generating .mcp.json..."
	@jq '.mcp_servers // {}' "$(PLUGINS_DIR)/$(PLUGIN).json" > "$(DIST_DIR)/plugins/$(PLUGIN)/.mcp.json"
	@echo "    $(GREEN)✓$(NC) .mcp.json"
	
	# Generate .claude-plugin/plugin.json
	@echo "  Generating .claude-plugin/plugin.json..."
	@jq '{name: .name, version: .version, description: .description, author: .author}' \
		"$(PLUGINS_DIR)/$(PLUGIN).json" > "$(DIST_DIR)/plugins/$(PLUGIN)/.claude-plugin/plugin.json"
	@echo "    $(GREEN)✓$(NC) .claude-plugin/plugin.json"
	
	@echo "$(GREEN)✓ $(PLUGIN) built successfully!$(NC)"

clean: ## Clean a specific plugin (usage: make clean PLUGIN=zapier-eng-plugin)
ifndef PLUGIN
	@echo "$(YELLOW)Error: PLUGIN not specified$(NC)"
	@echo "Usage: make clean PLUGIN=plugin-name"
	@exit 1
endif
	@echo "$(BLUE)Cleaning $(PLUGIN)...$(NC)"
	@rm -rf "$(DIST_DIR)/plugins/$(PLUGIN)"
	@echo "$(GREEN)✓ $(PLUGIN) cleaned!$(NC)"

clean-all: ## Clean all plugins
	@echo "$(BLUE)Cleaning all plugins...$(NC)"
	@rm -rf "$(DIST_DIR)/plugins"/*
	@echo "$(GREEN)✓ All plugins cleaned!$(NC)"

watch: ## Watch for changes and rebuild (requires fswatch)
ifndef PLUGIN
	@echo "$(YELLOW)Error: PLUGIN not specified$(NC)"
	@echo "Usage: make watch PLUGIN=plugin-name"
	@exit 1
endif
	@if ! command -v fswatch > /dev/null; then \
		echo "$(YELLOW)Error: fswatch not installed$(NC)"; \
		echo "Install with: brew install fswatch"; \
		exit 1; \
	fi
	@echo "$(BLUE)Watching for changes in skills/ and commands/...$(NC)"
	@echo "$(YELLOW)Press Ctrl+C to stop$(NC)"
	@fswatch -o $(SKILLS_DIR) $(COMMANDS_DIR) | while read num; do \
		echo "$(BLUE)Changes detected, rebuilding $(PLUGIN)...$(NC)"; \
		$(MAKE) build-plugin PLUGIN=$(PLUGIN); \
	done

zip-skills: ## Create zip files for all individual skills
	@echo "$(BLUE)Creating skill zip files...$(NC)"
	@mkdir -p "$(DIST_DIR)/skills"
	@for skill_dir in $(SKILLS_DIR)/*; do \
		if [ -d "$$skill_dir" ] && [ -f "$$skill_dir/SKILL.md" ]; then \
			skill_name=$$(basename "$$skill_dir"); \
			echo "  Zipping $$skill_name..."; \
			cd "$(SKILLS_DIR)" && zip -r "$(DIST_DIR)/skills/$$skill_name.zip" "$$skill_name" -x "*.DS_Store" > /dev/null; \
			echo "    $(GREEN)✓$(NC) $(DIST_DIR)/skills/$$skill_name.zip"; \
		fi; \
	done
	@echo "$(GREEN)✓ All skills zipped!$(NC)"

