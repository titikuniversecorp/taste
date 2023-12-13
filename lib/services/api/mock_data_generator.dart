
import '../../models/banner_model.dart';
import '../../models/product_category.dart';
import '../../models/product_model.dart';
import '../../models/ingridient_model.dart';
import '../../models/restaurant_model.dart';
import '../../models/user_address_model.dart';

class MockDataGenerator {
  static Future<List<UserAddressModel>> getUserAdresses() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      UserAddressModel(
        id: 1,
        city: 'Тула',
        street: 'Агеева',
        house: '1А'
      ),
      UserAddressModel(
        id: 2,
        city: 'Тула',
        street: 'Проспект Ленина',
        house: '98'
      )
    ];
  }

  static Future<RestaurantModel> getRestaurantMockData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return RestaurantModel(
      id: 0,
      name: "Taste",
      waitTime: [const Duration(minutes: 5), const Duration(minutes: 30)],
      distanse: 550,
      label: "Resaurant",
      score: 4.8,
      logoUrl: "assets/images/res_logo.jpg",
      description: "В этой концепции ваш ресторан представляет собой виртуальный мир вкусов, где гости могут погрузиться в уникальное путешествие по разнообразным вкусам. Каждое блюдо становится отдельным пунктом на кулинарной карте этого удивительного мира, и гости приглашаются насладиться разнообразием вкусовых переживаний",
      currency: '₽',
      categories: [
        ProductCategoryModel(
          id: 0,
          name: 'Сэм меню',
          backgroundImageUrl: 'assets/dishes/sam_menu/samburger/samburger.png', // assets/categories/sam-menu.png
          backgroundColor: null,
          productContainers: [
            ProductContainerModel(
              id: 0,
              products: [
                ProductModel(
                  id: 0,
                  name: 'Сэмбургер',
                  calories: 254,
                  price: 389,
                  weight: 350,
                  waitTime: [const Duration(minutes: 15)],
                  imageUrl: 'assets/dishes/sam_menu/samburger/samburger.png',
                  galleryImages: [
                    'assets/dishes/sam_menu/samburger/samburger.png',
                  ],
                  about: 'Флагманский огромный бургер',
                  description: null,
                  score: 4.7,
                  ingridients: [
                    IngridientModel(id: 0, name: 'Лапша', imageUrl: 'assets/images/ingre1.png'),
                    IngridientModel(id: 1, name: 'Креветка', imageUrl: 'assets/images/ingre2.png'),
                    IngridientModel(id: 2, name: 'Яйцо', imageUrl: 'assets/images/ingre3.png'),
                    IngridientModel(id: 3, name: 'Зелень', imageUrl: 'assets/images/ingre4.png'),
                  ]
                ),
              ]
            ),
            ProductContainerModel(
              id: 1,
              products: [
                ProductModel(
                  id: 1,
                  name: 'Сэмдвич',
                  calories: 297,
                  price: 89,
                  weight: 120,
                  waitTime: [const Duration(minutes: 3)],
                  imageUrl: 'assets/dishes/sam_menu/samdvish/samdvish1.png',
                  galleryImages: [
                    'assets/dishes/sam_menu/samdvish/samdvish1.png',
                    "assets/dishes/sam_menu/samdvish/samdvish2.png"
                  ],
                  about: 'Вафля вместо булочки!? 😱',
                  description: null,
                  score: 4.9,
                  ingridients: [
                    IngridientModel(id: 0, name: 'Яйцо', imageUrl: 'assets/images/ingre3.png'),
                    IngridientModel(id: 2, name: 'Креветка', imageUrl: 'assets/images/ingre2.png'),
                  ]
                ),
              ]
            ),
            ProductContainerModel(
              id: 2,
              products: [
                ProductModel(
                  id: 2,
                  name: 'Волнистый бургер',
                  calories: 297,
                  price: 149,
                  weight: 155,
                  waitTime: [const Duration(minutes: 7)],
                  imageUrl: 'assets/dishes/sam_menu/reflony_burger/grill-burger.png',
                  galleryImages: [
                    'assets/dishes/sam_menu/reflony_burger/grill-burger.png',
                  ],
                  about: 'Приятные ощущения',
                  description: null,
                  score: 4.9,
                  ingridients: [
                    IngridientModel(id: 0, name: 'Яйцо', imageUrl: 'assets/images/ingre3.png'),
                    IngridientModel(id: 2, name: 'Креветка', imageUrl: 'assets/images/ingre2.png'),
                  ]
                ),
              ]
            ),
            ProductContainerModel(
              id: 3,
              products: [
                ProductModel(
                  id: 3,
                  name: 'Сансет',
                  calories: 75,
                  price: 89,
                  weight: 400,
                  waitTime: null,
                  imageUrl: 'assets/dishes/sam_menu/slime/slime.png',
                  galleryImages: [
                    'assets/dishes/sam_menu/slime/slime.png'
                  ],
                  about: 'Состоит из двух видов сока',
                  description: null,
                  score: 4.3,
                  ingridients: [
                    IngridientModel(id: 0, name: 'Яйцо', imageUrl: 'assets/images/ingre3.png'),
                    IngridientModel(id: 2, name: 'Креветка', imageUrl: 'assets/images/ingre2.png'),
                  ]
                ),
              ]
            ),
          ]
        ),
        ProductCategoryModel(
          id: 1,
          name: 'Мит Маффины',
          backgroundImageUrl: 'assets/dishes/meat_maffin/meatmaffin-light.png', // assets/categories/burgers.png
          backgroundColor: null,
          productContainers: [
            ProductContainerModel(
              id: 4,
              products: [
                ProductModel(
                  id: 4,
                  name: 'Мит Маффин',
                  calories: 254,
                  price: 89,
                  weight: 100,
                  waitTime: [const Duration(minutes: 5)],
                  imageUrl: 'assets/dishes/meat_maffin/meatmaffin-light.png',
                  galleryImages: [
                    'assets/dishes/meat_maffin/meatmaffin-light.png',
                  ],
                  about: 'Очень вкусный, с сыром',
                  description: null,
                  score: 4.7,
                  ingridients: [
                    IngridientModel(id: 0, name: 'Лапша', imageUrl: 'assets/images/ingre1.png'),
                    IngridientModel(id: 1, name: 'Креветка', imageUrl: 'assets/images/ingre2.png'),
                    IngridientModel(id: 2, name: 'Яйцо', imageUrl: 'assets/images/ingre3.png'),
                    IngridientModel(id: 3, name: 'Зелень', imageUrl: 'assets/images/ingre4.png'),
                  ]
                ),
              ]
            ),
            ProductContainerModel(
              id: 5,
              products: [
                ProductModel(
                  id: 5,
                  name: 'Мит Маффин с яйцом',
                  calories: 297,
                  price: 129,
                  weight: 150,
                  waitTime: [const Duration(minutes: 5), const Duration(minutes: 10)],
                  imageUrl: 'assets/dishes/meat_maffin/meatmaffin-medium.png',
                  galleryImages: [
                    'assets/dishes/meat_maffin/meatmaffin-medium.png'
                  ],
                  about: 'Самый популярный утром',
                  description: null,
                  score: 4.9,
                  ingridients: [
                    IngridientModel(id: 0, name: 'Яйцо', imageUrl: 'assets/images/ingre3.png'),
                    IngridientModel(id: 2, name: 'Креветка', imageUrl: 'assets/images/ingre2.png'),
                  ]
                ),
              ]
            ),
            ProductContainerModel(
              id: 6,
              products: [
                ProductModel(
                  id: 6,
                  name: 'Мит Маффин Фреш',
                  calories: 458,
                  price: 189,
                  weight: 200,
                  waitTime: [const Duration(minutes: 10)],
                  imageUrl: 'assets/dishes/meat_maffin/meatmaffin-large.png',
                  galleryImages: [
                    'assets/dishes/meat_maffin/meatmaffin-large.png'
                  ],
                  about: 'Овощи + мясо = ❤️',
                  description: null,
                  score: 4.3,
                  ingridients: [
                    IngridientModel(id: 0, name: 'Яйцо', imageUrl: 'assets/images/ingre3.png'),
                    IngridientModel(id: 2, name: 'Креветка', imageUrl: 'assets/images/ingre2.png'),
                  ]
                ),
              ]
            ),
          ]
        ),
        ProductCategoryModel(
          id: 2,
          name: 'Закуски',
          backgroundImageUrl: 'assets/dishes/potato_pancakes/hashbraun.png', // assets/categories/starters.png
          backgroundColor: null,
          productContainers: [
            ProductContainerModel(
              id: 7,
              products: [
                ProductModel(
                  id: 7,
                  name: 'Картофельный оладушек',
                  calories: 367,
                  price: 49,
                  weight: 70,
                  waitTime: [const Duration(minutes: 5)],
                  imageUrl: 'assets/dishes/potato_pancakes/hashbraun.png',
                  galleryImages: [
                    'assets/dishes/potato_pancakes/hashbraun.png',
                    'assets/dishes/potato_pancakes/potato_pancake1.png',
                    'assets/dishes/potato_pancakes/potato_pancake2.png',
                    'assets/dishes/potato_pancakes/potato_pancake3.png'
                  ],
                  about: 'Хрустящий снаружи, магкий внутри',
                  description: null,
                  score: 4.7,
                  highLight: false,
                  ingridients: [
                    IngridientModel(id: 0, name: 'Яйцо', imageUrl: 'assets/images/ingre3.png'),
                    IngridientModel(id: 2, name: 'Креветка', imageUrl: 'assets/images/ingre2.png'),
                  ]
                ),
              ]
            ),
            ProductContainerModel(
              id: 8,
              products: [
                ProductModel(
                  id: 8,
                  name: 'Жаренный лонг',
                  calories: 367,
                  price: 49,
                  weight: 120,
                  waitTime: [const Duration(minutes: 5)],
                  imageUrl: 'assets/dishes/corn_dog/corndog_transparent_bg.png',
                  galleryImages: [
                    'assets/dishes/corn_dog/corndog_transparent_bg.png'
                  ],
                  about: 'Хрустящая панировка',
                  description: '«Жаренный лонг» - обжаренная в гладком хрустящем тесте сосиска с вкраплениями специй. Пикантный аромат и неотъемлимый элемент твоего перекуса сегодня',
                  score: 4.7,
                  highLight: false,
                  ingridients: [
                    IngridientModel(id: 0, name: 'Яйцо', imageUrl: 'assets/images/ingre3.png'),
                    IngridientModel(id: 2, name: 'Креветка', imageUrl: 'assets/images/ingre2.png'),
                  ]
                ),
              ]
            ),
          ]
        ),
      ],
      banners: [
        BannerModel(
          id: 0,
          label: 'Тут сочный бургер 🍔',
          description: 'Нажми, чтобы вкусно покушать сегодня',
          backgroundImageUrl: 'assets/banners/banner3.jpg',
          linkedProduct: ProductModel(
            id: 0,
            name: 'Сэмбургер',
            calories: 254,
            price: 389,
            weight: 350,
            waitTime: [const Duration(minutes: 15)],
            imageUrl: 'assets/dishes/sam_menu/samburger/samburger.png',
            galleryImages: [
              'assets/dishes/sam_menu/samburger/samburger.png',
            ],
            about: 'Флагманский огромный бургер',
            description: null,
            score: 4.7,
            ingridients: [
              IngridientModel(id: 0, name: 'Лапша', imageUrl: 'assets/images/ingre1.png'),
              IngridientModel(id: 1, name: 'Креветка', imageUrl: 'assets/images/ingre2.png'),
              IngridientModel(id: 2, name: 'Яйцо', imageUrl: 'assets/images/ingre3.png'),
              IngridientModel(id: 3, name: 'Зелень', imageUrl: 'assets/images/ingre4.png'),
            ]
          ),
        ),
        BannerModel(
          id: 2,
          label: 'Выгодное предложение!',
          description: 'Купи пиццу и вторая в подарок 😱',
          backgroundImageUrl: 'assets/banners/banner2.jpg'
        )
      ],
    );
  }
}