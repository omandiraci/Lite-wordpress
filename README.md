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

## 🔐 Güvenlik Özellikleri

Bu proje aşağıdaki güvenlik önlemlerini içerir:

### WordPress Güvenlik Ayarları
- ✅ **WordPress Security Keys**: Güçlü şifreleme anahtarları
- ✅ **Debug Modu Kapalı**: Üretim ortamında debug bilgileri gizli
- ✅ **Dosya Düzenleme Engellendi**: wp-config.php üzerinden dosya düzenleme kapalı
- ✅ **SSL Zorunlu**: Admin paneli için SSL zorunlu
- ✅ **Revizyon Sınırı**: Post revizyonları sınırlandırıldı
- ✅ **Otomatik Kaydetme**: Otomatik kaydetme süresi artırıldı

### Docker Güvenlik Ayarları
- ✅ **Read-Only Container**: Container'lar salt okunur modda çalışır
- ✅ **No New Privileges**: Container'lar yeni yetkiler alamaz
- ✅ **Specific User**: WordPress www-data kullanıcısı ile çalışır
- ✅ **Tmpfs**: Geçici dosyalar RAM'de saklanır
- ✅ **Specific Versions**: Sabit sürüm numaraları kullanılır

### Ek Güvenlik Önerileri
1. **Güçlü Şifreler**: Admin, FTP ve veritabanı şifrelerini güçlü tutun
2. **2FA**: İki faktörlü kimlik doğrulama kullanın
3. **Güvenlik Eklentileri**: Wordfence, Sucuri gibi eklentiler kurun
4. **Düzenli Güncellemeler**: WordPress, tema ve eklentileri güncel tutun
5. **Yedekleme**: Düzenli yedekleme yapın
6. **SSL Sertifikası**: Üretim ortamında SSL sertifikası kullanın

## Lisans

Bu proje MIT lisansı altında lisanslanmıştır.
