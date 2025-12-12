.PHONY: help build build-all clean clean-all list-plugins

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

help: ## Show this help message
	@echo "$(BLUE)Available targets:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-15s$(NC) %s\n", $$1, $$2}'

list-plugins: ## List all available plugins
	@echo "$(BLUE)Available plugins:$(NC)"
	@for plugin_dir in $(PLUGINS_DIR)/*; do \
		if [ -d "$$plugin_dir" ]; then \
			plugin_name=$$(basename "$$plugin_dir"); \
			if [ -f "$$plugin_dir/manifest.json" ]; then \
				echo "  $(GREEN)✓$(NC) $$plugin_name (has manifest)"; \
			else \
				echo "  $(YELLOW)○$(NC) $$plugin_name (no manifest)"; \
			fi; \
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
	@for plugin_dir in $(PLUGINS_DIR)/*; do \
		if [ -d "$$plugin_dir" ] && [ -f "$$plugin_dir/manifest.json" ]; then \
			plugin_name=$$(basename "$$plugin_dir"); \
			echo "$(BLUE)Building $$plugin_name...$(NC)"; \
			$(MAKE) build-plugin PLUGIN=$$plugin_name; \
		fi; \
	done
	@echo "$(GREEN)✓ All plugins built successfully!$(NC)"

build-plugin:
	@if [ ! -f "$(PLUGINS_DIR)/$(PLUGIN)/manifest.json" ]; then \
		echo "$(YELLOW)Error: manifest.json not found in $(PLUGINS_DIR)/$(PLUGIN)$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Building $(PLUGIN)...$(NC)"
	
	# Clean existing skills and commands (except .gitkeep)
	@find "$(PLUGINS_DIR)/$(PLUGIN)/skills" -mindepth 1 ! -name '.gitkeep' -delete 2>/dev/null || true
	@find "$(PLUGINS_DIR)/$(PLUGIN)/commands" -mindepth 1 ! -name '.gitkeep' -delete 2>/dev/null || true
	@mkdir -p "$(PLUGINS_DIR)/$(PLUGIN)/skills"
	@mkdir -p "$(PLUGINS_DIR)/$(PLUGIN)/commands"
	
	# Copy skills
	@echo "  Copying skills..."
	@skills=$$(jq -r '.skills[]?' "$(PLUGINS_DIR)/$(PLUGIN)/manifest.json"); \
	for skill in $$skills; do \
		if [ -d "$(SKILLS_DIR)/$$skill" ]; then \
			echo "    $(GREEN)✓$(NC) $$skill"; \
			cp -r "$(SKILLS_DIR)/$$skill" "$(PLUGINS_DIR)/$(PLUGIN)/skills/"; \
		else \
			echo "    $(YELLOW)✗$(NC) $$skill (not found)"; \
		fi; \
	done
	
	# Copy commands
	@echo "  Copying commands..."
	@commands=$$(jq -r '.commands[]?' "$(PLUGINS_DIR)/$(PLUGIN)/manifest.json"); \
	for cmd in $$commands; do \
		if [ -f "$(COMMANDS_DIR)/$$cmd.md" ]; then \
			echo "    $(GREEN)✓$(NC) $$cmd"; \
			mkdir -p "$$(dirname "$(PLUGINS_DIR)/$(PLUGIN)/commands/$$cmd.md")"; \
			cp "$(COMMANDS_DIR)/$$cmd.md" "$(PLUGINS_DIR)/$(PLUGIN)/commands/$$cmd.md"; \
		else \
			echo "    $(YELLOW)✗$(NC) $$cmd (not found)"; \
		fi; \
	done
	
	@echo "$(GREEN)✓ $(PLUGIN) built successfully!$(NC)"

clean: ## Clean a specific plugin (usage: make clean PLUGIN=zapier-eng-plugin)
ifndef PLUGIN
	@echo "$(YELLOW)Error: PLUGIN not specified$(NC)"
	@echo "Usage: make clean PLUGIN=plugin-name"
	@exit 1
endif
	@echo "$(BLUE)Cleaning $(PLUGIN)...$(NC)"
	@find "$(PLUGINS_DIR)/$(PLUGIN)/skills" -mindepth 1 ! -name '.gitkeep' -delete 2>/dev/null || true
	@find "$(PLUGINS_DIR)/$(PLUGIN)/commands" -mindepth 1 ! -name '.gitkeep' -delete 2>/dev/null || true
	@echo "$(GREEN)✓ $(PLUGIN) cleaned!$(NC)"

clean-all: ## Clean all plugins
	@echo "$(BLUE)Cleaning all plugins...$(NC)"
	@for plugin_dir in $(PLUGINS_DIR)/*; do \
		if [ -d "$$plugin_dir" ]; then \
			plugin_name=$$(basename "$$plugin_dir"); \
			echo "  Cleaning $$plugin_name..."; \
			find "$$plugin_dir/skills" -mindepth 1 ! -name '.gitkeep' -delete 2>/dev/null || true; \
			find "$$plugin_dir/commands" -mindepth 1 ! -name '.gitkeep' -delete 2>/dev/null || true; \
		fi; \
	done
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

