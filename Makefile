build-CryptoLayer:
	mkdir -p "$(ARTIFACTS_DIR)/python"
	python -m pip install --platform manylinux2014_x86_64 --implementation cp --python-version 3.10 --only-binary=:all: --upgrade -r requirements.txt -t "$(ARTIFACTS_DIR)/python"
