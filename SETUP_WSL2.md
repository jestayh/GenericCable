# GenericCable Setup en WSL2

## 🔴 PASO 0: Instalar dependencias del sistema (PRIMERO)

**IMPORTANTE**: Esto SOLO se hace UNA VEZ antes de crear el ambiente conda.

### Opción A: Ejecutar el script
```bash
chmod +x INSTALL_SYSTEM_DEPS.sh
./INSTALL_SYSTEM_DEPS.sh
```

### Opción B: Comando manual
```bash
sudo apt-get update
sudo apt-get install -y libcufft-dev-12-1 cuda-nvrtc-dev-12-1 cuda-nvrtc-12-1
```

### Verificar CUDA
```bash
nvcc --version
```

---

## Requisitos previos en Windows/WSL2

### 1. CUDA Toolkit instalado en WSL2
Verificar que CUDA está disponible:
```bash
nvcc --version
```

### 2. ✅ Librerías CUDA necesarias (ver PASO 0 arriba)
Ya están instaladas si ejecutaste el script o comando manual.

## Instalación de GenericCable

### 1. Clonar el repositorio
```bash
git clone https://github.com/jestayh/GenericCable.git
cd GenericCable
```

### 2. Crear el ambiente conda

**Importante**: El `environment.yml` ya está configurado correctamente. NO incluye:
- `pytorch-cuda=12.1` (puede causar conflictos)
- Canal `nvidia` (innecesario, PyTorch ya proporciona CUDA)

Crear el ambiente:
```bash
conda env create -f environment.yml -y
```

### 3. Activar el ambiente
```bash
conda activate genericcable
```

### 4. Primera importación (compilación de seisfwi)
La primera vez que importes seisfwi, compilará el código CUDA:
```bash
python -c "import seisfwi; print('✓ seisfwi compiled and imported')"
```

Esto puede tomar 2-5 minutos la primera vez. Las compilaciones posteriores serán instantáneas.

## Verificación de la instalación

```bash
conda activate genericcable
python << 'EOF'
import torch
import seisfwi
import genericcable

print("✓ PyTorch:", torch.__version__)
print("✓ CUDA available:", torch.cuda.is_available())
print("✓ seisfwi imported")
print("✓ genericcable imported")
EOF
```

## Usar Jupyter Lab

```bash
conda activate genericcable
jupyter lab --ip=0.0.0.0 --allow-root --no-browser
```

Luego accede desde tu navegador en `http://localhost:8888`

## Problemas comunes

### Error: "cufft.h: No such file or directory"
**Solución**: Instalar `libcufft-dev-12-1`
```bash
sudo apt-get install -y libcufft-dev-12-1
```

### Error: "cannot find -lnvrtc"
**Solución**: Instalar `cuda-nvrtc-dev-12-1 cuda-nvrtc-12-1`
```bash
sudo apt-get install -y cuda-nvrtc-dev-12-1 cuda-nvrtc-12-1
```

### Error: "ModuleNotFoundError: No module named 'imagex'"
**Solución**: Ya está arreglado. Si lo necesitas de nuevo:
```bash
find /home/josee/miniconda3/envs/genericcable/lib/python3.10/site-packages/seisfwi -name "*.py" -exec sed -i 's/from imagex/from seisfwi/g' {} \;
```

## Notas para WSL2

- **GPU NVIDIA**: WSL2 tiene acceso directo a la GPU de Windows, PyTorch la detecta automáticamente
- **CUDA**: Se usa el CUDA 12.1 del sistema (instalado previamente en WSL2)
- **No necesitas nvidia channel**: PyTorch proporciona todo lo necesario

## Versiones instaladas

```
Python: 3.10
PyTorch: 2.5.1
CUDA: 12.1
NumPy: >=1.26.4,<2.0.0
seisfwi: latest (from PyPI)
genericcable: 0.0.4 (local install)
```

