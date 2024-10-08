# list all available commands
default:
  just --list

###############################################################################
# Basic project and env management

# clean all build, python, and lint files
clean:
	rm -fr dist
	rm -fr .eggs
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +
	rm -fr .mypy_cache
	rm -fr .pytest_cache

# install with all deps
install:
	pip install uv
	uv pip install -e ".[test,lint,dev]"

# download data
download-test-resources:
	pip install uv
	uv pip install -e ".[data]"
	python scripts/download_test_resources.py
	uv pip uninstall quilt3
	just install

# lint, format, and check all files
lint:
	pre-commit run --all-files

# run tests
test:
	pytest napari_bioio

###############################################################################
# Release and versioning

# tag a new version
tag-for-release version:
	git tag -a "{{version}}" -m "{{version}}"
	echo "Tagged: $(git tag --sort=-version:refname| head -n 1)"

# release a new version
release:
	git push --follow-tags
