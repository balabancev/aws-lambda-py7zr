FROM public.ecr.aws/lambda/python:3.12

RUN <<EOF
dnf update -y 
dnf install zip -y 
dnf install python3 -y 
python3 -m pip install --upgrade pip 
EOF
   
RUN mkdir /python \
    && mkdir /lambda_layer \
    && mkdir /app

COPY ./requirements.txt /app/requirements.txt
COPY ./install.sh /app/install.sh

RUN chmod +x /app/install.sh

ENV PIP_ROOT_USER_ACTION=ignore


ENTRYPOINT [ "/app/install.sh" ]

# ENTRYPOINT [ "/bin/bash" ]