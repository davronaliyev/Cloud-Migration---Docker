## Setup MinIO server on Docker


* Open PowerShell as an Administrator.

* Run below code to create new MinIO server.

        docker run -d --restart=always -p 9000:9000 -p 9013:9013 --name minio -e "MINIO_ROOT_USER=minioadmin" -e "MINIO_ROOT_PASSWORD=minioadmin1!" -v C:\MinIO:/data  quay.io/minio/minio server /data --console-address ":9013"

* Check if container is created and up and running.

        docker ps -a

* Open a browser and go to this URL "127.0.0.1:9013" and use minioadmin / minioadmin1! to login.
Click on the plus icon and create a bucket "gitlab-runner-cache".