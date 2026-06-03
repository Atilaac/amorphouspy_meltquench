<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/logo_inverted.png">
    <img src="docs/assets/logo.png" alt="amorphouspy logo" width="400"/>
  </picture>
</p>

# Silica Glass via Melt-Quench (amorphouspy)

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Atilaac/amorphouspy_meltquench/HEAD?labpath=example.ipynb)

Demonstrates a minimal melt-quench workflow for producing a silica glass structure using **amorphouspy** + LAMMPS.

## Installation

```bash
# Install amorphouspy (from the amorphouspy repo)
cd /path/to/amorphouspy
pixi install

# Or with pip
pip install amorphouspy
```

## Run the workflow

```bash
jupyter lab
# open example.ipynb and run all cells
```

## What the notebook does

| Step | Description |
|------|-------------|
| 1 | Build a random 300-atom SiO₂ starting structure |
| 2 | Generate the SHIK interatomic potential |
| 3 | Run the 6-stage melt-quench protocol via LAMMPS |
| 4 | Plot temperature and volume traces per stage |
| 5 | Compute and report glass density |
| 6 | Compute partial RDFs (Si-O, O-O, Si-Si) |
| 7 | Check Si coordination number distribution |
| 8 | Save the final glass structure as `.extxyz` |

## Production settings

The notebook uses fast rates (`1e15 K/s`) and short equilibration (`10000 steps`) for demonstration. For production:

```python
result = am.melt_quench_simulation(
    structure=atoms,
    potential=potential,
    temperature_high=5000.0,
    temperature_low=300.0,
    timestep=1.0,
    cooling_rate=1e12,   # 1 K/ps — physically more realistic
    # remove equilibration_steps to use protocol defaults
    seed=42,
)
```

## Potential choice

SHIK is used here because it was developed specifically for SiO₂ and aluminosilicate systems. 

See the [documentation](https://glasagent.github.io/amorphouspy/) for more detail.
