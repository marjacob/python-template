SHELL = /bin/sh

##### Variables
##############################################################################

# Python
python_bin    := $(shell which python3)

# Requirements
req_floating  := requirements-to-freeze.txt
req_pinned    := requirements.txt

# Virtual environment (do not change the ordering).
venv_path     := .venv
venv_bin_path := $(venv_path)/bin
venv_activate := $(venv_bin_path)/activate
venv_exec     := source $(venv_activate) && exec

# Virtual environment tools.
venv_pip      := $(venv_exec) pip
venv_pylint   := $(venv_exec) pylint
venv_python   := $(venv_exec) python

##### Functions
##############################################################################

# Build a virtual environment.
define venv-create =
	@test -d $(venv_path) || virtualenv -p $(python_bin) $(venv_path)
endef

# Generate a pinned package list.
define venv-pip-freeze =
	$(venv_pip) freeze > $(req_pinned)
endef

# Install updated versions of all packages.
define venv-pip-install =
	$(venv_pip) install -Ur $(1)
	touch $(venv_activate)
endef

##### Rules
##############################################################################

default: $(venv_path)

# Build the virtual environment.
$(venv_path): $(venv_activate)
$(venv_activate): $(req_floating) Makefile
	@$(call venv-create)
	@$(call venv-pip-install,$(req_floating))

# Save a list of all currently installed packages with pinned version numbers.
.PHONY: freeze
freeze: $(venv_path)
	@$(call venv-pip-freeze)

# Install the latest version of all packages.
.PHONY: upgrade
upgrade: $(venv_path)
	@$(call venv-pip-install,$(req_floating))

# Generate linting report.
.PHONY: lint
lint: $(venv_path)
	@$(venv_pylint) --rcfile=pylintrc --output-format=text src

# Execute the code inside the virtual environment.
.PHONY: run
run: $(venv_path)
	@$(venv_python) -tt src/main.py

.PHONY: restore
restore: clean
	@$(call venv-create)
	@$(call venv-pip-install,$(req_pinned))

# Perform unit tests.
.PHONY: test
test: $(venv_path)
	@$(venv_exec) green --processes 1 --run-coverage -v src

# Destroy the virtual environment and cache files.
.PHONY: clean
clean:
	@$(RM) -rf $(venv_path)
	@find src -name __pycache__ -type d -prune -exec $(RM) -rf {} \;

