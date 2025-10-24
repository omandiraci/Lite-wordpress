# Lite WordPress

Bu proje Docker kullanarak WordPress ve MySQL veritabanını kolayca çalıştırmanızı sağlar.

## Gereksinimler

- Docker
- Docker Compose

## Kurulum

1. Projeyi klonlayın:
```bash
git clone <repository-url>
cd Lite-Workpress
```

2. `.env` dosyası oluşturun:
```bash
cp .env.example .env
```

3. `.env` dosyasını düzenleyin ve gerekli değişkenleri ayarlayın.

4. Docker container'ları başlatın:
```bash
docker-compose up -d
```

## Kullanım

- WordPress: http://localhost:8080
- MySQL veritabanı: localhost:3306

## Durdurma

Container'ları durdurmak için:
```bash
docker-compose down
```

## Verileri Kalıcı Hale Getirme

Veriler Docker volume'larında saklanır:
- `mysqlvolume`: MySQL veritabanı verileri
- `wpvolume`: WordPress dosyaları

## Lisans

Bu proje MIT lisansı altında lisanslanmıştır.
