FROM public.ecr.aws/lambda/python:3.9.2024.03.28.16-x86_64

#Update
RUN yum update -y

#Copy Python
COPY python .

#Set ENV Variable
#ENV PATH='python/venv/bin'

#Set up Dependencies?
COPY requirements.txt .
RUN pip install -r requirements.txt

#preinstall torch.hub.vits
RUN python -c "import torch; torch.hub.set_dir('/tmp/torch/hub'); torch.hub.load('facebookresearch/dinov2', 'dinov2_vits14')"
RUN cp -r /tmp/torch .
#Copy lambda py to task root
COPY python/code/main.py ${LAMBDA_TASK_ROOT}

#Copy packages to lib
#COPY python/venv/lib /var/lang/lib/

#Set cmd to handler
CMD [ "main.lambda_handler" ]
