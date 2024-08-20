#! /bin/bash

pip install -r /app/requirements.txt -t /python

chmod -R 755 /python 
zip -r /lambda_layer/package.zip /python

python -c "import pip; import sys; sys.path.insert(0, '/python'); pip.main(['list', '-v'])"