FROM python:3.8-slim-bullseye

EXPOSE 8321

WORKDIR /app

COPY requirements.txt /app

RUN sed -i "s@http://deb.debian.org@http://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && \
    apt-get update && apt-get install -y \
    libgl1 libgomp1 libglib2.0-0 libsm6 libxrender1 libxext6 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade pip && \
    pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    pip3 install --no-cache-dir -r requirements.txt

COPY . /app

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8321"]
