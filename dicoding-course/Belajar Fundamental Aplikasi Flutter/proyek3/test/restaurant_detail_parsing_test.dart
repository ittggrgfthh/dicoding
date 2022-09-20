import 'package:flutter_test/flutter_test.dart';
import 'package:proyek3/data/model/restaurant_detail.dart';

void main() {
  group('Restaurant', () {
    test('Parsing Restaurant Detail Model ke Json', () async {
      final restaurantDetail = RestaurantDetailModel(
        error: false,
        message: "",
        restaurant: RestaurantDetail(
          id: 'id',
          name: 'name',
          description: 'description',
          city: 'city',
          address: 'address',
          pictureId: 'pictureId',
          rating: 0,
          categories: [],
          menus: Menus(
            foods: [],
            drinks: [],
          ),
          customerReviews: [],
        ),
      );
      expect(restaurantDetail.toJson(), {
        'error': false,
        'message': "",
        'restaurant': {
          'id': 'id',
          'name': 'name',
          'description': 'description',
          'city': 'city',
          'address': 'address',
          'pictureId': 'pictureId',
          'rating': 0,
          'categories': [],
          'menus': {
            'foods': [],
            'drinks': [],
          },
          'customerReviews': [],
        }
      });
    });
    test('Parsing Restaurant Detail Model dari Json', () async {
      Map<String, dynamic> restaurantDetailJson = {
        'error': false,
        'message': "",
        'restaurant': {
          'id': 'id',
          'name': 'name',
          'description': 'description',
          'city': 'city',
          'address': 'address',
          'pictureId': 'pictureId',
          'rating': 0,
          'categories': [],
          'menus': {
            'foods': [],
            'drinks': [],
          },
          'customerReviews': [],
        }
      };
      expect(RestaurantDetailModel.fromJson(restaurantDetailJson),
          isA<RestaurantDetailModel>());
    });

    test('Gagal Parsing Restaurant Detail Model dari Json', () async {
      Map<String, dynamic> restaurantDetailJson = {
        'error': false,
        'message': "",
        'restaurant': {}
      };

      expect(
        () => RestaurantDetailModel.fromJson(restaurantDetailJson),
        throwsA(const TypeMatcher<TypeError>()),
      );
    });
  });
}
