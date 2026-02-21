#!/bin/bash
# ============================================================================
# INSTALAR DEPENDENCIAS DEL SISTEMA PARA GENERICCABLE EN WSL2
# ============================================================================
#
# Este script instala las librerías CUDA necesarias a nivel del sistema.
# DEBE ejecutarse UNA SOLA VEZ antes de crear el ambiente conda.
#
# Uso:
#   chmod +x INSTALL_SYSTEM_DEPS.sh
#   ./INSTALL_SYSTEM_DEPS.sh
#
# O manualmente:
#   sudo apt-get update
#   sudo apt-get install -y libcufft-dev-12-1 cuda-nvrtc-dev-12-1 cuda-nvrtc-12-1

echo "=========================================="
echo "Instalando dependencias del sistema..."
echo "=========================================="

# Actualizar repositorios
echo "[1/3] Actualizando repositorios apt..."
sudo apt-get update

# Instalar librerías CUDA necesarias para compilar seisfwi
echo "[2/3] Instalando librerías CUDA..."
sudo apt-get install -y libcufft-dev-12-1

echo "[3/3] Instalando compilador CUDA runtime (nvrtc)..."
sudo apt-get install -y cuda-nvrtc-dev-12-1 cuda-nvrtc-12-1

echo ""
echo "=========================================="
echo "✅ Dependencias del sistema instaladas"
echo "=========================================="
echo ""
echo "Próximos pasos:"
echo "  conda env create -f environment.yml -y"
echo "  conda activate genericcable"
echo ""
