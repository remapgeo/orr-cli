# Definir o ambiente para o bash
SHELL := /bin/bash

# Variáveis auxiliares
DIST_DIR := dist

.PHONY: build_install

# Limpa, faz build e instala o .whl em um único comando
build_install:
	@if [ -d "$(DIST_DIR)" ]; then \
		echo "Limpando a pasta $(DIST_DIR)..."; \
		rm -rf $(DIST_DIR); \
	else \
		echo "Pasta $(DIST_DIR) não encontrada, prosseguindo..."; \
	fi
	@echo "Construindo a biblioteca..."
	poetry build
	@echo "Instalando a biblioteca localmente..."
	@pip install --force-reinstall $(DIST_DIR)/*.whl
	@echo "Processo concluído com sucesso!"