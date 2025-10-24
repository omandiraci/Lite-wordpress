#!/bin/bash

# Lite WordPress Kurulum Scripti
# Bu script güvenli bir şekilde .env dosyası oluşturur

set -e

echo "🚀 Lite WordPress Kurulum Scripti"
echo "=================================="

# Renk kodları
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# .env dosyası kontrolü
if [ -f ".env" ]; then
    echo -e "${YELLOW}⚠️  .env dosyası zaten mevcut!${NC}"
    read -p "Üzerine yazmak istiyor musunuz? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Kurulum iptal edildi."
        exit 1
    fi
fi

# Güçlü şifre oluşturma fonksiyonu
generate_password() {
    openssl rand -base64 32 | tr -d "=+/" | cut -c1-25
}

# Güvenlik anahtarı oluşturma fonksiyonu (Docker Compose uyumlu)
generate_key() {
    openssl rand -hex 32
}

# Logs klasörlerini oluştur
mkdir -p logs/wordpress logs/database
echo -e "${GREEN}📁 Logs klasörleri oluşturuldu${NC}"
echo -e "${GREEN}   • logs/wordpress/ - WordPress logları${NC}"
echo -e "${GREEN}   • logs/database/ - MySQL logları${NC}"

echo -e "${GREEN}🔐 Güvenli şifreler ve anahtarlar oluşturuluyor...${NC}"

# Şifreler oluştur
DB_PASSWORD=$(generate_password)
echo "✅ Veritabanı şifresi oluşturuldu"

# Güvenlik anahtarları oluştur
AUTH_KEY=$(generate_key)
SECURE_AUTH_KEY=$(generate_key)
LOGGED_IN_KEY=$(generate_key)
NONCE_KEY=$(generate_key)
AUTH_SALT=$(generate_key)
SECURE_AUTH_SALT=$(generate_key)
LOGGED_IN_SALT=$(generate_key)
NONCE_SALT=$(generate_key)
echo "✅ WordPress güvenlik anahtarları oluşturuldu"

# .env dosyası oluştur
cat > .env << EOF
# MySQL Database Configuration
MYSQL_DATABASE=wpdatabase
MYSQL_USER=wpuser
MYSQL_PASSWORD=${DB_PASSWORD}

# WordPress Database Configuration
WORDPRESS_DB_HOST=db
WORDPRESS_DB_USER=wpuser
WORDPRESS_DB_PASSWORD=${DB_PASSWORD}
WORDPRESS_DB_NAME=wpdatabase

# WordPress Security Keys
WORDPRESS_AUTH_KEY=${AUTH_KEY}
WORDPRESS_SECURE_AUTH_KEY=${SECURE_AUTH_KEY}
WORDPRESS_LOGGED_IN_KEY=${LOGGED_IN_KEY}
WORDPRESS_NONCE_KEY=${NONCE_KEY}
WORDPRESS_AUTH_SALT=${AUTH_SALT}
WORDPRESS_SECURE_AUTH_SALT=${SECURE_AUTH_SALT}
WORDPRESS_LOGGED_IN_SALT=${LOGGED_IN_SALT}
WORDPRESS_NONCE_SALT=${NONCE_SALT}

# WordPress Security Settings
WORDPRESS_DEBUG=false
WORDPRESS_DEBUG_LOG=false
WORDPRESS_DEBUG_DISPLAY=false
WORDPRESS_SCRIPT_DEBUG=false
WORDPRESS_DISALLOW_FILE_EDIT=true
WORDPRESS_DISALLOW_FILE_MODS=true
WORDPRESS_FORCE_SSL_ADMIN=true
WORDPRESS_WP_POST_REVISIONS=3
WORDPRESS_AUTOSAVE_INTERVAL=300
WORDPRESS_EMPTY_TRASH_DAYS=7
EOF

echo -e "${GREEN}✅ .env dosyası güvenli şekilde oluşturuldu${NC}"

# Dosya izinlerini güvenli hale getir
chmod 600 .env
echo -e "${GREEN}✅ .env dosyası izinleri güvenli hale getirildi (600)${NC}"

# Docker container'larını başlat
echo -e "${YELLOW}🐳 Docker container'ları başlatılıyor...${NC}"
docker-compose up -d

# Kurulum kontrolü
echo -e "${YELLOW}🔍 Kurulum kontrol ediliyor...${NC}"
sleep 10

if docker-compose ps | grep -q "Up"; then
    echo -e "${GREEN}✅ Kurulum başarılı!${NC}"
    echo -e "${GREEN}🌐 WordPress: http://localhost:8080${NC}"
    echo -e "${GREEN}🗄️  MySQL: localhost:3306${NC}"
    echo ""
    echo -e "${YELLOW}📝 Önemli Bilgiler:${NC}"
    echo -e "   • Veritabanı Şifresi: ${DB_PASSWORD}"
    echo -e "   • .env dosyası güvenli şekilde oluşturuldu"
    echo -e "   • Güvenlik anahtarları otomatik oluşturuldu"
    echo ""
    echo -e "${RED}⚠️  GÜVENLİK UYARISI:${NC}"
    echo -e "   • .env dosyasını kimseyle paylaşmayın"
    echo -e "   • Şifreleri güvenli bir yerde saklayın"
    echo -e "   • Üretim ortamında SSL sertifikası kullanın"
else
    echo -e "${RED}❌ Kurulum başarısız! Log'ları kontrol edin:${NC}"
    docker-compose logs
    exit 1
fi
