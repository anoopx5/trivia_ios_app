class TravelPlace {
  const TravelPlace({
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.category,
    required this.description,
    required this.bestTime,
    required this.duration,
    required this.insiderTip,
    required this.highlights,
  });

  final String id;
  final String name;
  final String location;
  final String image;
  final String category;
  final String description;
  final String bestTime;
  final String duration;
  final String insiderTip;
  final List<String> highlights;
}

class TravelCountry {
  const TravelCountry({
    required this.id,
    required this.name,
    required this.region,
    required this.headline,
    required this.description,
    required this.image,
    required this.bestSeason,
    required this.language,
    required this.currency,
    required this.places,
  });

  final String id;
  final String name;
  final String region;
  final String headline;
  final String description;
  final String image;
  final String bestSeason;
  final String language;
  final String currency;
  final List<TravelPlace> places;
}

const countries = <TravelCountry>[
  TravelCountry(
    id: 'japan',
    name: 'Japan',
    region: 'East Asia',
    headline: 'Tradition meets tomorrow',
    description: 'Ancient shrines, neon-lit streets, mountain scenery and thoughtful hospitality make Japan endlessly fascinating.',
    image: 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=1100&q=85',
    bestSeason: 'Mar–May · Sep–Nov',
    language: 'Japanese',
    currency: 'Japanese yen (JPY)',
    places: [
      TravelPlace(
        id: 'kyoto', name: 'Fushimi Inari Shrine', location: 'Kyoto',
        image: 'https://images.unsplash.com/photo-1478436127897-769e1b3f0f36?w=1100&q=85',
        category: 'Culture',
        description: 'Follow paths lined with thousands of vermilion torii gates on the forested slopes of Mount Inari. The further uphill you go, the quieter the atmosphere becomes.',
        bestTime: 'Early morning or late afternoon', duration: '2–3 hours',
        insiderTip: 'Walk beyond the first crowded photo spots for quieter stretches of the torii trail.',
        highlights: ['Torii-gate tunnels', 'Forest walking trails', 'Traditional shrines'],
      ),
      TravelPlace(
        id: 'fuji', name: 'Mount Fuji', location: 'Honshu',
        image: 'https://images.unsplash.com/photo-1713018605257-a50e9231feef?w=1100&q=85',
        category: 'Nature',
        description: 'Japan’s iconic volcanic peak rises above lakes and mountain towns. On clear days, the views around the Fuji Five Lakes area are unforgettable.',
        bestTime: 'Nov–Feb for clear views', duration: '1–2 days',
        insiderTip: 'Climbing has a separate official season; check current access rules and weather before making plans.',
        highlights: ['Fuji Five Lakes', 'Panoramic viewpoints', 'Mountain landscapes'],
      ),
      TravelPlace(
        id: 'tokyo', name: 'Shibuya Crossing', location: 'Tokyo',
        image: 'https://images.unsplash.com/photo-1542051841857-5f90071e7989?w=1100&q=85',
        category: 'City life',
        description: 'See the energy of modern Tokyo at the famous scramble crossing, surrounded by shopping streets, restaurants and bright city lights.',
        bestTime: 'Evening', duration: '1–2 hours',
        insiderTip: 'Explore the surrounding lanes for cafés and smaller local shops after you visit the crossing.',
        highlights: ['Scramble crossing', 'City lights', 'Food and shopping'],
      ),
    ],
  ),
  TravelCountry(
    id: 'france',
    name: 'France',
    region: 'Western Europe',
    headline: 'Art, charm and timeless streets',
    description: 'From Parisian landmarks and world-class museums to dramatic coastlines and medieval villages, France rewards slow exploration.',
    image: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=1100&q=85',
    bestSeason: 'Apr–Jun · Sep–Oct',
    language: 'French',
    currency: 'Euro (EUR)',
    places: [
      TravelPlace(
        id: 'eiffel', name: 'Eiffel Tower', location: 'Paris',
        image: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=1100&q=85',
        category: 'Landmark',
        description: 'The unmistakable iron tower is a symbol of Paris, with sweeping city views from its visitor levels and beautiful riverside surroundings.',
        bestTime: 'Sunset and after dark', duration: '2–3 hours',
        insiderTip: 'Book official timed tickets in advance, particularly in peak travel months.',
        highlights: ['City panoramas', 'Evening illumination', 'Seine riverside walks'],
      ),
      TravelPlace(
        id: 'louvre', name: 'Louvre Museum', location: 'Paris',
        image: 'https://images.unsplash.com/photo-1499856871958-5b9627545d1a?w=1100&q=85',
        category: 'Art & history',
        description: 'Explore one of the world’s great art museums in a former royal palace, with collections spanning centuries and civilizations.',
        bestTime: 'Weekday morning', duration: '3–5 hours',
        insiderTip: 'Choose a few collections beforehand: the museum is far too large to see everything in one visit.',
        highlights: ['Historic galleries', 'Glass pyramid', 'Masterpiece collections'],
      ),
      TravelPlace(
        id: 'montsaint', name: 'Mont Saint-Michel', location: 'Normandy',
        image: 'https://images.unsplash.com/photo-1757874905949-8d3d5e67e9a4?w=1100&q=85',
        category: 'Heritage',
        description: 'A medieval abbey crowns a tidal island, connected to the mainland by a causeway. The changing tides transform the landscape throughout the day.',
        bestTime: 'Spring or autumn', duration: 'Half to full day',
        insiderTip: 'Check the official tide timetable; never cross surrounding tidal flats without an authorized guide.',
        highlights: ['Hilltop abbey', 'Medieval lanes', 'Tidal bay'],
      ),
    ],
  ),
  TravelCountry(
    id: 'italy',
    name: 'Italy',
    region: 'Southern Europe',
    headline: 'History around every corner',
    description: 'Discover Roman monuments, waterways, coastal villages and an unforgettable food culture.',
    image: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5?w=1100&q=85',
    bestSeason: 'Apr–Jun · Sep–Oct',
    language: 'Italian',
    currency: 'Euro (EUR)',
    places: [
      TravelPlace(
        id: 'colosseum', name: 'Colosseum', location: 'Rome',
        image: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5?w=1100&q=85',
        category: 'Ancient history',
        description: 'Step into the Roman world at an extraordinary amphitheatre that has stood for almost two millennia.',
        bestTime: 'Early morning', duration: '2–3 hours',
        insiderTip: 'Reserve an official entry slot; combine your visit with the Roman Forum nearby.',
        highlights: ['Ancient architecture', 'Arena history', 'Roman Forum nearby'],
      ),
      TravelPlace(
        id: 'venice', name: 'Grand Canal', location: 'Venice',
        image: 'https://images.unsplash.com/photo-1514890547357-a9ee288728e0?w=1100&q=85',
        category: 'Romantic escape',
        description: 'Venice’s main waterway winds between centuries-old palaces and bridges. Ride a vaporetto to see the city from the water.',
        bestTime: 'Apr–May · Sep–Oct', duration: 'Half day',
        insiderTip: 'Use the public water bus for an affordable canal journey with excellent views.',
        highlights: ['Canal-side palaces', 'Rialto Bridge', 'Water-bus journeys'],
      ),
      TravelPlace(
        id: 'amalfi', name: 'Amalfi Coast', location: 'Campania',
        image: 'https://images.unsplash.com/photo-1533105079780-92b9be482077?w=1100&q=85',
        category: 'Coast & nature',
        description: 'Colorful towns cling to steep Mediterranean cliffs along a spectacular stretch of Italian coastline.',
        bestTime: 'May–Jun · Sep', duration: '2–3 days',
        insiderTip: 'Ferries can be easier than driving between towns during busy summer periods.',
        highlights: ['Cliffside villages', 'Sea views', 'Coastal walks'],
      ),
    ],
  ),
  TravelCountry(
    id: 'india',
    name: 'India',
    region: 'South Asia',
    headline: 'A world of wonders',
    description: 'India brings together grand architecture, vibrant cities, living traditions and lush natural landscapes.',
    image: 'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=1100&q=85',
    bestSeason: 'Oct–Mar for many regions',
    language: 'Many regional languages',
    currency: 'Indian rupee (INR)',
    places: [
      TravelPlace(
        id: 'taj', name: 'Taj Mahal', location: 'Agra',
        image: 'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=1100&q=85',
        category: 'UNESCO heritage',
        description: 'This luminous white-marble mausoleum, built by Mughal emperor Shah Jahan, is celebrated for its symmetry and exquisite craftsmanship.',
        bestTime: 'Sunrise · Oct–Mar', duration: '2–3 hours',
        insiderTip: 'The monument is generally closed to regular visitors on Fridays; confirm official hours before visiting.',
        highlights: ['Marble inlay', 'Reflecting gardens', 'Mughal architecture'],
      ),
      TravelPlace(
        id: 'amber', name: 'Amber Fort', location: 'Jaipur',
        image: 'https://images.unsplash.com/photo-1599661046827-dacff0c0f09a?w=1100&q=85',
        category: 'Royal heritage',
        description: 'A hilltop fort-palace with elaborate courtyards, mirrored halls and sweeping views over the rugged Aravalli landscape.',
        bestTime: 'Oct–Mar · morning', duration: '2–4 hours',
        insiderTip: 'Wear comfortable footwear: the complex involves uphill approaches and plenty of walking.',
        highlights: ['Sheesh Mahal', 'Royal courtyards', 'Fort viewpoints'],
      ),
      TravelPlace(
        id: 'backwaters', name: 'Kerala Backwaters', location: 'Alappuzha',
        image: 'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=1100&q=85',
        category: 'Slow travel',
        description: 'Drift past palm-lined canals, villages and rice fields in Kerala’s peaceful network of waterways.',
        bestTime: 'Nov–Feb', duration: 'Half day to overnight',
        insiderTip: 'Compare boat safety standards and the route before booking a houseboat or day cruise.',
        highlights: ['Houseboat cruises', 'Village waterways', 'Tropical scenery'],
      ),
    ],
  ),
  TravelCountry(
    id: 'uae',
    name: 'United Arab Emirates',
    region: 'Middle East',
    headline: 'Bold skylines and desert horizons',
    description: 'Go from futuristic city towers to remarkable architecture and vast golden desert landscapes.',
    image: 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=1100&q=85',
    bestSeason: 'Nov–Mar',
    language: 'Arabic · English widely used',
    currency: 'UAE dirham (AED)',
    places: [
      TravelPlace(
        id: 'burj', name: 'Burj Khalifa', location: 'Dubai',
        image: 'https://images.unsplash.com/photo-1518684079-3c830dcef090?w=1100&q=85',
        category: 'Architecture',
        description: 'Experience Dubai from one of the world’s most recognizable supertall skyscrapers and its observation decks.',
        bestTime: 'Sunset', duration: '1–2 hours',
        insiderTip: 'Observation-deck tickets are often cheaper when reserved ahead for non-peak time slots.',
        highlights: ['Sky-high views', 'Downtown Dubai', 'Modern architecture'],
      ),
      TravelPlace(
        id: 'mosque', name: 'Sheikh Zayed Grand Mosque', location: 'Abu Dhabi',
        image: 'https://images.unsplash.com/photo-1580418827493-f2b22c0a76cb?w=1100&q=85',
        category: 'Culture',
        description: 'A magnificent white-marble mosque celebrated for its domes, courtyards, intricate decoration and serene reflective pools.',
        bestTime: 'Late afternoon', duration: '1–2 hours',
        insiderTip: 'Review visitor dress requirements and any current entry reservation rules on the official site.',
        highlights: ['White marble domes', 'Reflection pools', 'Ornate interiors'],
      ),
      TravelPlace(
        id: 'desert', name: 'Dubai Desert', location: 'Dubai outskirts',
        image: 'https://images.unsplash.com/photo-1509316785289-025f5b846b35?w=1100&q=85',
        category: 'Adventure',
        description: 'Leave the skyline behind for rolling sand dunes, expansive horizons and unforgettable sunset colors.',
        bestTime: 'Nov–Mar · golden hour', duration: 'Half day',
        insiderTip: 'Use licensed guides for desert excursions and bring water, sun protection and suitable footwear.',
        highlights: ['Golden dunes', 'Sunset views', 'Desert landscapes'],
      ),
    ],
  ),
  TravelCountry(
    id: 'switzerland',
    name: 'Switzerland',
    region: 'Central Europe',
    headline: 'The great Alpine escape',
    description: 'Discover dramatic mountains, clear lakes, postcard-perfect towns and some of Europe’s most scenic rail journeys.',
    image: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1100&q=85',
    bestSeason: 'Jun–Sep · Dec–Mar',
    language: 'German, French, Italian, Romansh',
    currency: 'Swiss franc (CHF)',
    places: [
      TravelPlace(
        id: 'matterhorn', name: 'Matterhorn', location: 'Zermatt',
        image: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1100&q=85',
        category: 'Mountains',
        description: 'The instantly recognizable pyramid-shaped Alpine peak towers over Zermatt and inspires hikers, photographers and mountain lovers.',
        bestTime: 'Jun–Sep for hiking', duration: '1–2 days',
        insiderTip: 'Mountain visibility changes quickly; keep your plans flexible and check lift schedules.',
        highlights: ['Alpine panoramas', 'Mountain railways', 'Hiking trails'],
      ),
      TravelPlace(
        id: 'lucerne', name: 'Lake Lucerne', location: 'Lucerne',
        image: 'https://www.lakelucerne.ch/fileadmin/_processed_/7/0/csm_Boat_Trip_Lake_Lucerne_c45e09434e.jpg',
        category: 'Lakeside',
        description: 'A beautiful lake framed by mountain ranges, historic waterside buildings and scenic boat routes.',
        bestTime: 'May–Sep', duration: 'Half to full day',
        insiderTip: 'Combine a lake boat ride with a walk through Lucerne’s compact old town.',
        highlights: ['Lake cruises', 'Mountain views', 'Old-town walks'],
      ),
      TravelPlace(
        id: 'lauterbrunnen', name: 'Lauterbrunnen Valley', location: 'Bernese Oberland',
        image: 'https://images.unsplash.com/photo-1590664216212-62e763768cae?w=1100&q=85',
        category: 'Nature',
        description: 'A deep green valley with steep rock walls, charming villages and waterfalls tumbling from high cliffs.',
        bestTime: 'May–Sep', duration: '1–2 days',
        insiderTip: 'Allow time for the walking paths and nearby villages rather than visiting only for a photo stop.',
        highlights: ['Valley walks', 'Waterfalls', 'Alpine villages'],
      ),
    ],
  ),
];

List<TravelPlace> get allPlaces => [
  for (final country in countries) ...country.places,
];

TravelCountry countryForPlace(TravelPlace place) =>
    countries.firstWhere((country) => country.places.any((item) => item.id == place.id));
