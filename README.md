# Build AWS Lambda Layers for Python runtime 

A solution to build [AWS Lambda Layers](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html) for Python runtime when packages depend on system libraries specific to the OS.

Lambda runs on Amazon Linux. Python wheels built on ``Mac OS`` or ``Windows`` may not work on Lambda.


E.g. [AWS Lambda Layers](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html) built on ``Mac OS`` that contain ``cryptography``package will result in an error.
```shell
ImportError: /var/task/cryptography/hazmat/bindings/_constant_time.so: invalid ELF header
```
  ``cryptography`` contains native code and that code is compiled for the architecture of the current machine. [AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html) needs [Layers](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html) compiled as linux ELF shared objects. 

### Prerequisites
Install [Docker](https://docs.docker.com/install/) on your local machine. 

## Usage

Find a suitable base image at [Amazon ECR Gallery](https://gallery.ecr.aws/lambda/python)

Update [Dockerfile](./lambda/Dockerfile) with the base image. 

    FROM public.ecr.aws/lambda/python:3.12

Update [requirements.txt](./lambda/requirements.txt) with the packages you want to include in the layer.

Start the container to build the layer mountinf [lambda_layer](./lambda_layer) directory to the container:

```
docker build -t lambda_base .
docker rm lambda_builder
docker run -v ./lambda_layer:/lambda_layer --name lambda_builder lambda_base
```

Once complete a zip archive will be available in the [lambda_layer](./lambda_layer) directory.

Upload the zip archive to AWS Lambda as a new layer or a version of an existing layer.