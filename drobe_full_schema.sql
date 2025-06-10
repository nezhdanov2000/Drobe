
-- Создание базы данных
CREATE DATABASE IF NOT EXISTS drobe_db;
USE drobe_db;

-- Таблица пользователей
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    password_hash VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица адресов
CREATE TABLE addresses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    city VARCHAR(100),
    street VARCHAR(100),
    building VARCHAR(20),
    apartment_office VARCHAR(20),
    postal_code VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Таблица заказов
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    address_id INT,
    total DECIMAL(10, 2),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'confirmed', 'shipped', 'delivered', 'cancelled'),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (address_id) REFERENCES addresses(id)
);

-- Таблица категорий
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE
);

-- Таблица цветов
CREATE TABLE colors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE
);

-- Таблица гендеров
CREATE TABLE genders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE
);

-- Таблица товаров
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    description TEXT,
    price DECIMAL(10, 2),
    stock INT,
    image_url VARCHAR(255),
    category_id INT,
    color_id INT,
    gender_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (color_id) REFERENCES colors(id),
    FOREIGN KEY (gender_id) REFERENCES genders(id)
);

-- Таблица товаров в заказе
CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Таблица обратной связи
CREATE TABLE callbacks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Вставка тестовых категорий
INSERT INTO categories (name) VALUES ('Рубашка'), ('Майка'), ('Штаны'), ('Куртка');

-- Вставка тестовых цветов
INSERT INTO colors (name) VALUES ('Белый'), ('Чёрный'), ('Синий'), ('Красный');

-- Вставка тестовых типов одежды
INSERT INTO genders (name) VALUES ('Мужская'), ('Женская'), ('Унисекс');

-- Вставка тестовых товаров
INSERT INTO products (name, description, price, stock, image_url, category_id, color_id, gender_id)
VALUES 
('Белая рубашка', 'Классическая белая рубашка из хлопка', 1200.00, 10, 'shirt_white.jpg', 1, 1, 1),
('Красная майка', 'Яркая красная майка для спорта', 800.00, 15, 'tank_red.jpg', 2, 4, 2),
('Синие штаны', 'Удобные синие повседневные штаны', 1500.00, 8, 'pants_blue.jpg', 3, 3, 3),
('Чёрная куртка', 'Тёплая чёрная зимняя куртка', 3000.00, 5, 'jacket_black.jpg', 4, 2, 1);





-- Категории товаров
INSERT INTO categories (name) VALUES 
('Майка'), 
('Рубашка'), 
('Штаны'), 
('Куртка');

-- Цвета товаров
INSERT INTO colors (name) VALUES 
('Черный'), 
('Белый'), 
('Синий'), 
('Красный');

-- Типы одежды (гендер)
INSERT INTO genders (name) VALUES 
('Мужская'), 
('Женская'), 
('Унисекс');

-- Продукты
INSERT INTO products (name, description, price, stock, image_url, category_id, color_id, gender_id) VALUES
('Майка SummerFit', 'Легкая майка для тренировок', 590.00, 25, 'summerfit.jpg', 1, 2, 3),
('Рубашка Classic White', 'Белая рубашка с длинным рукавом', 1290.00, 10, 'classic_white.jpg', 2, 2, 1),
('Штаны StreetStyle', 'Удобные штаны в городском стиле', 990.00, 18, 'streetstyle.jpg', 3, 1, 1),
('Куртка RedZone', 'Теплая зимняя куртка', 1990.00, 7, 'redzone.jpg', 4, 4, 2);

-- Пользователи
INSERT INTO users (name, email, phone, password_hash) VALUES
('Иван Иванов', 'ivan@example.com', '+79991234567', 'hashedpass1'),
('Мария Смирнова', 'maria@example.com', '+79997654321', 'hashedpass2');

-- Адреса
INSERT INTO addresses (user_id, city, street, building, apartment_office, postal_code) VALUES
(1, 'Москва', 'Тверская', '12', '34', '101000'),
(2, 'Санкт-Петербург', 'Невский проспект', '55', '12А', '190000');

-- Заказы
INSERT INTO orders (user_id, address_id, total, comment, status) VALUES
(1, 1, 590.00, 'Позвоните перед доставкой', 'confirmed'),
(2, 2, 2280.00, 'Оставьте на охране', 'shipped');

-- Состав заказов
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 590.00),
(2, 2, 1, 1290.00),
(2, 3, 1, 990.00);

-- Обратный звонок
INSERT INTO callbacks (name, phone, email) VALUES
('Сергей Петров', '+79993456789', 'sergey@example.com'),
('Анна Козлова', '+79999887766', 'anna@example.com');
