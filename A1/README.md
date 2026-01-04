# A1 | Test Project – Nginx + Docker

This project demonstrates a simple Dockerized web application using **nginx** and **Docker Compose**.

---

## Prerequisites

* Docker
* Docker Compose (v2+)
* Ubuntu 22.04 LTS

---

## Steps

### 1. Create project directory

Create a directory for the project:

```bash
mkdir test-project
cd test-project
```

---

### 2. Create Dockerfile

Create a `Dockerfile` based on `nginx:alpine` and remove default static files:

```dockerfile
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
```

---

### 3. Create index.html

Create a simple `index.html` file in the project directory:

```html
<!DOCTYPE html>
<html>
  <body>
    <h1>Hello from NailAmber</h1>
  </body>
</html>
```

---

### 4. Build the Docker image

Build the Docker image with the tag `my-web-app:latest`:

```bash
docker build -t my-web-app:latest .
```

---

### 5. Run the container

Run the container and map port **8080** on the host to port **80** in the container:

```bash
docker run -p 8080:80 \
  -v $(pwd)/index.html:/usr/share/nginx/html/index.html:ro \
  my-web-app:latest
```

---

### 6. Run using Docker Compose

Alternatively, start the service using Docker Compose:

```yml
services:
  web:
    build: .
    image: my-web-app:latest
    ports:
      - "8080:80"
    volumes:
      - ./index.html:/usr/share/nginx/html/index.html:ro

```

```bash
docker compose up -d
```

---

### 7. Verify result

Open a browser and navigate to:

```
http://localhost:8080
```

You should see the message:

```
Hello from NailAmber
```

---

### Notes

* `index.html` is mounted using a volume, so it can be changed without rebuilding the image.
* This approach is suitable for development and testing purposes.
