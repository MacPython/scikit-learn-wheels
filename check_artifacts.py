"""Checks that dist/* contains the number of artifacts built from the
azure-pipelines.yml config."""
import sys
from pathlib import Path
import yaml

azure_config_path = Path("azure-pipelines.yml")
dist_dir = Path("dist")

if not dist_dir.exists():
    print("dist directory does not exist")
    sys.exit(1)

n_dist_files = len(list(dist_dir.glob('**/*')))

# get number of artifacts built with azure-pipelines.yaml
with azure_config_path.open('r') as f:
    azure_config = yaml.safe_load(f)

n_artifacts = 0
for job in azure_config['jobs']:
    if 'parameters' not in job:  # sdist
        n_artifacts += 1
        continue
    n_artifacts += len(job['parameters']['matrix'])

if n_dist_files != n_artifacts:
    print(f"Expected {n_artifacts} artifacts in dist/* but "
          f"got {n_dist_files} artifacts instead.")
    sys.exit(1)

print(f"dist/* has the expected {n_artifacts} artifacts")
