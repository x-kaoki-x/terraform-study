# terraform-study
Terraform学習

# 起動手順
## envファイルを作成
`.env.（環境名）`
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- AWS_DEFAULT_REGION

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