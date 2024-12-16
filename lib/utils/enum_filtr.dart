enum FilterType {
  brand,
  model,
  generation,
  modification,
  year,
  mileage,
  currency,
  price,
  bodyType,
  service,
  fuel,
  transmission,
  color,
  numberOfOwners,
  externalBodyKit,
  optics,
  salon,
  media,
  carOptions,
  configurations,
  description,
  time24,
  timeFrom,
  timeTo,
  replacedParts,
  photography,
  none,
  region,
  contact,
  status
}

enum Tables {
  user,
  category,
  product,
  serves,
  ingredient,
  role,
  images,
  favorite;

  String get text => switch (this) {
        Tables.user => 'users',
        Tables.favorite => 'favorite',
        Tables.images => 'images',
        Tables.category => 'category',
        Tables.ingredient => 'ingredient',
        Tables.serves => 'serves',
        Tables.product => 'product',
        Tables.role => 'role',
      };
}
