# Setup Profesional para GenericCable

Este repositorio ha sido configurado para investigación geofísica de alto rendimiento (DAS, FWI).

## Requisitos Previos
- NVIDIA Drivers instalados.
- Miniconda o Anaconda.

## Gestión del Ambiente

### 1. Creación del Ambiente
Si aún no lo has hecho, crea el ambiente desde la raíz del repo:
```bash
conda env create -f environment.yml
```

### 2. Activación
```bash
conda activate genericcable
```

### 3. Verificación de GPU y seisfwi
Hemos incluido un script de diagnóstico:
```bash
python verify_setup.py
```

## Estructura de Dependencias Críticas
- **Python 3.10**: Compatibilidad máxima con `seisfwi`.
- **PyTorch + CUDA 11.8**: Motor de cálculo para el propagador elástico.
- **seisfwi**: Herramienta de inversión sísmica integrada.
- **GenericCable (editable)**: Instalado con `pip install -e .` para desarrollo activo.

## Calidad de Código
Antes de hacer un commit, puedes usar las herramientas incluidas:
- `black .`: Formateo automático.
- `pytest`: Pruebas unitarias.
