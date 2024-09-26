# **Point of Sale App**

The POS Android Tablet Application is a robust and intuitive point-of-sale solution designed specifically for businesses in the foodservice industries. Tailored for Android tablets, this application streamlines the sales process, enhances customer service, and simplifies inventory and order management.

![Thumbnail](https://github.com/user-attachments/assets/b45fb444-80f5-491d-8648-2a44be2a69b9)

## **Key Features**

1. **User-Friendly Interface:** The application offers an intuitive, responsive interface optimized for tablet devices, ensuring ease of use for employees and administrators alike. 
2. **Order Management:** Efficiently handle orders and supports various transaction methods. 
3. **Product Categorization:** Organize products into customizable categories (e.g., food, drinks, snacks) for quick access during transactions. 
4. **Data Integration:** The application integrates with sqflite database to store and retrieve product details and sales records. 
5. **Offline Mode:** Continue processing transactions during network disruptions.

## **Pre-Installation (Laravel API endpoints)**

To install this app, you must to install the Laravel POS API project fist. Follow these steps:

1. Clone the repository: **`git clone https://github.com/my-khoirunnisa/laravel-posresto-backend-khoirunnisa.git`**
2. Navigate to the project directory: **`cd project-title`**
3. Install dependencies: **`composer install`**
4. Copy the .env.example: **`cp .env.example .env`**
5. Generate key: **`php artisan key:generate`**
6. Migrate: **`php artisan migrate`**
7. Run the project: **`php artisan serve`**

## **Installation (Flutter) & Usage**

After install the Laravel POS API project, install and use the POS app. Follow these steps:

1. Clone the repository: **`git clone https://github.com/my-khoirunnisa/flutter-pos-tab.git`**
2. Navigate to the project directory: **`cd project-title`**
3. Install dependencies: **`flutter pub get`**
4. Set the base-url in variables.dart file: **`static const String baseUrl = 'http://your_ip_address:8000';`**
5. Start or run the project: **`flutter run`**
6. Use the project as desired.

## **Authors and Acknowledgment**

Point of Sale App was created by **[Khoirunnisa'](https://github.com/my-khoirunnisa)**.

## **Contact**

If you have any questions or comments about this project, please contact **[Khoirunnisa'](work.khoirunnisa@gmail.com)**.

## **Conclusion**

The POS Android Tablet Application is a powerful, user-friendly solution tailored to streamline sales, enhance operational efficiency, and provide real-time insights for small to medium-sized businesses. With its comprehensive features and seamless integration, it is designed to meet the evolving needs of modern foodservice environments, delivering a reliable and flexible point-of-sale experience.
