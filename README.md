# terraform-study
Terraform学習

# 起動手順
## 環境ごとにimageをbuild
```
docker build -t my-terraform:staging -f ./staging/Dockerfile .
```
## build
```
docker-compose build
```

## 環境ごとに起動
```
docker-compose run --rm staging
```