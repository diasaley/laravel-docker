# Laravel

Laravel adalah PHP framework yang dibuat oleh Taylor Otwell dan ditujukan untuk pengembangan aplikasi web yang mengikuti pola arsitektur model-view-controller (MVC). Laravel adalah salah satu PHP framework yang paling populer dan digunakan oleh berbagai jenis bisnis dan organisasi. Laravel dikenal karena kemudahannya dalam penggunaan, fleksibilitas, dan kekuatannya. Laravel menyediakan seperangkat alat dan fitur yang komprehensif untuk memudahkan pengembangan aplikasi web berkualitas tinggi.

### Requirements

Laravel memiliki beberapa persyaratan sistem (system requirements) khususnya versi PHP dan ekstensinya:
- PHP >=8.1
- Ctype PHP Extension
- cURL PHP Extension
- DOM PHP Extension
- Fileinfo PHP Extension
- Filter PHP Extension
- Hash PHP Extension
- Mbstring PHP Extension
- OpenSSL PHP Extension
- PCRE PHP Extension
- PDO PHP Extension
- Session PHP Extension
- Tokenizer PHP Extension
- XML PHP Extension

### Install PHP

Instal PHP beserta ekstensi yang dibutuhkan dan yang sering digunakan.
```sh
$ sudo apt install php php-cli php-common php-mbstring php-gd php-intl php-xml php-mysql php-zip php-curl php-tidy php-imagick -y 
```
Menampilkan versi PHP yang terinstall:
```sh
$ php -v
```
Contoh hasil perintahnya:
```sh
PHP 8.1.2-1ubuntu2.11 (cli) (built: Feb 22 2023 22:56:18) (NTS)
Copyright (c) The PHP Group
Zend Engine v4.1.2 Copyright (c) Zend Technologies
with Zend OPcache v8.1.2-1ubuntu2.11 Copyright (c) by Zend Technologies
```
Menampilkan daftar PHP extension yang terpasang:
```sh
$ php -m
```
Contoh hasil perintahnya:
```sh
[PHP Modules]
calendar
Core
ctype
...
zip
zlib

[Zend Modules]
Zend OPcache
```
### Install Composer
Laravel ini akan diinstal dengan menggunakan Composer.
```sh
$ wget https://getcomposer.org/download/latest-stable/composer.phar
$ sudo chown root:root composer.phar
$ sudo chmod +x composer.phar
$ sudo mv composer.phar /usr/local/bin/composer
```
lakukan satu persatu 

### Install Laravel
Membuat project baru untuk Laravel. Beri nama direktori sesuai keinginan:
```sh
$ composer create-project laravel/laravel=9.* nama-project
```
Jika ingin menggunakan Laravel versi terbaru tidak perlu menuliskan nomor versinya:
```sh
composer create-project laravel/laravel nama-project
```
Menampilkan versi Laravel yang digunakan:
```sh
$ cd nama-project
$ php artisan --version
```
Contoh hasil perintahnya: 
```sh
Laravel framework 9.52.16
```
Menguji hasil instalasi Laravel dengan menjalankan Laravel development server:
```sh
$ php artisan serve
```
Contoh hasil perintah:
```sh
INFO  Server running on [http://127.0.0.1:8000].

Press Ctrl+C to stop the server
```
Browse http://localhost:8000 untuk melihat hasil instalasi Laravel. Tekan CTRL+C untuk menghentikan development server.
Jika ingin mengakses menggunakan IP public dan custom port (bukan port 8080):
```sh
$ php artisan serve --host=0.0.0.0 --port=8080
```
Ketik ini jika ingin melihat hasilnya:
Akses IP-anda:8080 ke browser anda, contoh: 192.168.1.7:8080.

Selamat mencoba!

# Docker
Docker adalah layanan yang menyediakan kemampuan untuk mengemas dan menjalankan sebuah aplikasi dalam sebuah lingkungan terisolasi yang disebut dengan container. Dengan adanya isolasi dan keamanan yang memadai memungkinkan kamu untuk menjalankan banyak container di waktu yang bersamaan pada host tertentu.
### Cara Install 
Update Repository
```sh 
$ sudo apt update
```
Install aplikasi yang dibutuhkan
```sh 
$ sudo apt install apt-transport-https ca-certificates curl software-properties-common
```
Tambahkan GPG key untuk repository official Docker:
```sh
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```
Tambahkan Docker repository:
```sh
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
```
Update database paket:
```sh
$ sudo apt update
```
Jalankan perintah di bawah untuk memastikan versi docker yang terinstall:
```sh
$ apt-cache policy docker-ce
```
Install Docker:
```sh
$ sudo apt install docker-ce
```
Docker harusnya sudah terinstall sekarang daemon sudah berjalan dan otomatis run pada saat boot. Cara ceknya:
```sh
$ sudo systemctl status docker
```
Menjalankan perintah docker tanpa sudo (optional):
```sh
$ sudo usermod -aG docker {USER}
```
Silahkan log out dan log in 
# Laravel-Docker
Pada teknologi virtualisasi untuk menjalankan aplikasi kita perlu buat dahulu virtual machine (VM) pada server lalu install library atau setup environmentnya satu persatu untuk menjalankan aplikasi. Misal anda perlu install php, composer, mysql, redis dll agar aplikasi Anda dapat berjalan. Belum nanti ada perbedaan versi yang digunakan, maka ini akan menjadi sebuah problem. Berbeda jika dibanding menggunakan teknologi kontainerisasi, untuk menjalankan aplikasinya kita bisa buat aplikasi kita menjadi sebuah image atau artefak yang nantinya akan dijalankan pada kontainer.
### Cara deploy
Masuk ke direktori yang ada file Laravel-nya:
```sh
$ cd nama-project
```
Lalu buat file bernama Dockerfile:
```sh
$ nano Dockerfile
```
Lalu masukan script ini ke dalam Dockerfile:
```sh
FROM php:8.1.2-fpm-alpine

# enviroment variable
ENV \
	APP_DIR="/webapp" \
	APP_PORT="8001"

# memindahkan file atau folder ke driektori yang di inginkan di docker
COPY . $APP_DIR
COPY .env.example $APP_DIR/.env

# menginstall kebutuhnan yang ingin digunakna
RUN apk add --update \
	curl \
	php \
	php-opcache \
	php-openssl \
	php-pdo \
	php-json \
	php-phar \
	php-dom \
	&& rm -rf /var/cache/apk/*
	
# menginstall composer
RUN curl -sS https://getcomposer.org/installer | php -- \
	--install-dir=/usr/bin --filename=composer

# menjalankna perintah composer
RUN cd $APP_DIR && composer update
RUN cd $APP_DIR && php artisan key:generate

# entrypoin
WORKDIR $APP_DIR 

# menjaankan apikasi 
CMD ["sh", "-c", "php artisan serve --host=0.0.0.0 --port=${APP_PORT}"]

# run composer update
RUN composer update

# akses 
EXPOSE 
```
Note: di baris 5 dan 6 di situ ada APP_DIR dan APP_PORT, harus di sesuaikan cotnooh:
APP_DIR=”/webapp” \ (“webapp” karena nama direktori saya webapp) 
APP_PORT=”8001” (karena saya menggunakna port 8001) 

Lanjut lakukan command ini di bawah
```sh
$ docker build . –t laravel-docker:latest
```
Cek docker images (opsional)
```sh
$ docker images
```

Lalu lakukan command ini agar bisa menjalankan laravel di dalam docker
```sh
$ docker run –p 8001:8001 laravel-docker:latest
```
Selamat mencoba dan semoga berhasil 
