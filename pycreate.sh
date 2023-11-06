#! /bin/bash

#
#
# CREATES A NEW PYTHON PROJECT
#
#

# Get the root directory name from standard in
read -p "Name: " root_dir
read -p "Python Version (ex. 3.12): " version

# Make the root directory in the current directory
mkdir $root_dir

# Move into root directory
cd $root_dir

# Python package name
package_name="${root_dir//-/_}"
printf "Package Name: ${package_name}\n"

# Create virtual environment
py="python${version} -m venv .venv"
eval $py

# Create .gitignore
touch .gitignore

# Add files and directories to .gitignore
printf ".venv\n" >> .gitignore
printf ".idea\n" >> .gitignore
printf "**/__pycache__\n" >> .gitignore
printf ".pytest_cache\n" >> .gitignore
printf "build\n" >> .gitignore
printf "${package_name}.egg-info\n" >> .gitignore
printf "dist\n" >> .gitignore
printf "doc/build\n" >> .gitignore

# Additional directories
#mkdir build
#mkdir dist
mkdir doc
mkdir etc

# Base requirement files
touch etc/requirements.in
touch etc/requirements-dev.in

printf "# Dependencies for development and testing\n" >> etc/requirements-dev.in 
printf "pytest==7.4.3\n" >> etc/requirements-dev.in
#printf "setuptools==68.2.2\n" >> etc/requirements-dev.in
#printf "wheel==0.41.3\n" >> etc/requirements-dev.in
#printf "sphinx==7.2.6\n" >> etc/requirements-dev.in
#printf "sphinx-rtd-theme==1.3.0\n" >> etc/requirements-dev.in

mkdir $package_name
mkdir $package_name/data
touch $package_name/__init__.py
touch $package_name/__main__.py

# __main__.py
printf "import sys\n\n" >> $package_name/__main__.py

printf "from ${package_name}.cli import main\n\n" >> $package_name/__main__.py

printf "sys.exit(main(sys.argv))\n" >> $package_name/__main__.py

touch $package_name/cli.py

# cli.py
printf "def main(args: list[str]) -> int:\n" >> $package_name/cli.py
printf "    \"\"\"Entry point for ${package_name}.\"\"\"\n" >> $package_name/cli.py
printf "    print(args)\n" >> $package_name/cli.py
printf "    return 0\n" >> $package_name/cli.py

mkdir $package_name/tests
touch $package_name/tests/__init__.py

touch CONTRIBUTING.md

printf "## Setup Local Environment\n\n" >> CONTRIBUTING.md

printf "### Install developer dependencies\n" >> CONTRIBUTING.md
printf "\`\`$ pip install -r etc/requirements-dev.in\`\`\n\n" >> CONTRIBUTING.md

printf "### Running tests\n" >> CONTRIBUTING.md
printf "\`\`$ pytest\`\`\n\n" >> CONTRIBUTING.md

printf "### Building documentation\n" >> CONTRIBUTING.md
printf "\`\`\`\n" >> CONTRIBUTING.md
printf "$ cd doc\n" >> CONTRIBUTING.md
printf "$ make html\n" >> CONTRIBUTING.md
printf "\`\`\`" >> CONTRIBUTING.md

touch LICENSE

printf "https://choosealicense.com/licenses/" >> LICENSE

touch README.md

printf "## Description\n" >> README.md
printf "Welcome to the ${package_name} repository.\n\n" >> README.md

printf "## Requirements\n" >> README.md
printf -- "- Python >=3.11\n\n" >> README.md # '--' == end of options, treats the '-' literally

printf "## Installing\n" >> README.md
printf "\`\`$ pip install ${package_name}\`\`\n\n" >> README.md

printf "## Simple Example\n" >> README.md
printf "\`\`\`\n" >> README.md
printf "\$ ${package_name} run\n" >> README.md
printf "Running service...\n" >> README.md
printf "\`\`\`\n\n" >> README.md

printf "## Contributing\n" >> README.md
printf "See [contribution guidelines](CONTRIBUTING.md).\n" >> README.md

touch requirements-dev.lock
#touch setup.cfg
#touch setup.py

# setup.py
#printf "import setuptools\n\n" >> setup.py
#
#printf "setuptools.setup()\n\n" >> setup.py

# Next Steps
printf "\n\n"
printf "Next Steps: \n"
printf " - Run source .venv/bin/activate\n"
printf " - Run pip install -r etc/requirements-dev.in\n"
printf " - Run sphinx-quickstart\n"
printf " - Packaging"
printf "\n"
