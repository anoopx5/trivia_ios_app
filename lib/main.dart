import 'package:flutter/material.dart';
import 'travel_data.dart';

void main() => runApp(const TriviaTravelApp());

const _ink = Color(0xFF14283B);
const _muted = Color(0xFF71808E);
const _teal = Color(0xFF147D79);
const _cream = Color(0xFFF6F7F4);
const _orange = Color(0xFFFFCA87);

class TriviaTravelApp extends StatelessWidget {
  const TriviaTravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia Travel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _cream,
        colorScheme: ColorScheme.fromSeed(seedColor: _teal),
        appBarTheme: const AppBarTheme(
          backgroundColor: _cream,
          foregroundColor: _ink,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const TravelShell(),
    );
  }
}

class TravelShell extends StatefulWidget {
  const TravelShell({super.key});

  @override
  State<TravelShell> createState() => _TravelShellState();
}

class _TravelShellState extends State<TravelShell> {
  int _tab = 0;
  final Set<String> _saved = <String>{};

  bool _isSaved(TravelPlace place) => _saved.contains(place.id);

  void _toggleSaved(TravelPlace place) {
    setState(() {
      if (!_saved.add(place.id)) _saved.remove(place.id);
    });
  }

  void _openCountry(TravelCountry country) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => CountryPage(
        country: country,
        onOpenPlace: _openPlace,
      ),
    ));
  }

  void _openPlace(TravelPlace place) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => PlacePage(
        place: place,
        country: countryForPlace(place),
        initiallySaved: _isSaved(place),
        onToggleSaved: () => _toggleSaved(place),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tab,
        children: [
          DiscoverPage(onOpenCountry: _openCountry, onOpenPlace: _openPlace),
          SavedPage(
            savedPlaces: allPlaces.where(_isSaved).toList(),
            onOpenPlace: _openPlace,
            onExplore: () => setState(() => _tab = 0),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        height: 72,
        elevation: 0,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFDCF1EA),
        selectedIndex: _tab,
        onDestinationSelected: (index) => setState(() => _tab = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore, color: _teal),
            label: 'Discover',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.bookmark, color: _teal),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({
    required this.onOpenCountry,
    required this.onOpenPlace,
    super.key,
  });

  final ValueChanged<TravelCountry> onOpenCountry;
  final ValueChanged<TravelPlace> onOpenPlace;

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filter = _query.trim().toLowerCase();
    final countryMatches = countries.where((c) =>
        c.name.toLowerCase().contains(filter) ||
        c.region.toLowerCase().contains(filter)).toList();
    final placeMatches = allPlaces.where((p) =>
        p.name.toLowerCase().contains(filter) ||
        p.location.toLowerCase().contains(filter) ||
        p.category.toLowerCase().contains(filter) ||
        countryForPlace(p).name.toLowerCase().contains(filter)).toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 34),
        children: [
          const Row(
            children: [
              Icon(Icons.public, color: _teal, size: 25),
              SizedBox(width: 9),
              Text('TRIVIA', style: TextStyle(color: _ink, fontSize: 16,
                  fontWeight: FontWeight.w900, letterSpacing: 3)),
              Text('  /  TRAVEL', style: TextStyle(
                  color: _teal, fontSize: 11, letterSpacing: 2.2,
                  fontWeight: FontWeight.w800)),
              Spacer(),
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFE8EEE8),
                child: Icon(Icons.travel_explore, color: _teal),
              ),
            ],
          ),
          const SizedBox(height: 35),
          const Text('The world is\nwaiting for you.',
              style: TextStyle(color: _ink, fontSize: 35,
                  fontWeight: FontWeight.w900, height: 1.13,
                  letterSpacing: -1.3)),
          const SizedBox(height: 12),
          const Text('Discover extraordinary places, one journey at a time.',
              style: TextStyle(color: _muted, fontSize: 14.5, height: 1.5)),
          const SizedBox(height: 25),
          TextField(
            onChanged: (value) => setState(() => _query = value),
            decoration: InputDecoration(
              hintText: 'Search countries or famous places',
              hintStyle: const TextStyle(color: _muted, fontSize: 13.5),
              prefixIcon: const Icon(Icons.search, color: _teal),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 19),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 28),
          if (filter.isEmpty) ...[
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: SizedBox(
                  height: 270,
                  width: double.infinity,
                  child: TravelPhoto(url: countries.first.image),
                ),
              ),
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xDC0B2633)],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 23, right: 23, top: 22,
                child: Row(children: [
                  _Badge(text: 'EDITOR’S PICK', color: _orange),
                  const Spacer(),
                  const Icon(Icons.north_east, color: Colors.white),
                ]),
              ),
              Positioned(
                left: 23, right: 23, bottom: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('JAPAN', style: TextStyle(color: _orange,
                        fontSize: 11, fontWeight: FontWeight.w900,
                        letterSpacing: 2.5)),
                    const SizedBox(height: 7),
                    const Text('A journey through\nwonder',
                        style: TextStyle(color: Colors.white,
                            fontSize: 27, fontWeight: FontWeight.w800,
                            height: 1.13)),
                    const SizedBox(height: 15),
                    Row(children: [
                      const Text('Explore destination',
                          style: TextStyle(color: Colors.white,
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 7),
                      const Icon(Icons.arrow_forward,
                          color: Colors.white, size: 17),
                    ]),
                  ],
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () => widget.onOpenCountry(countries.first),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 34),
            const _SectionHeading(
              title: 'Explore countries',
              subtitle: 'Find your next unforgettable escape',
            ),
            const SizedBox(height: 17),
            LayoutBuilder(builder: (context, constraints) {
              final width = (constraints.maxWidth - 13) / 2;
              return Wrap(
                spacing: 13, runSpacing: 13,
                children: [
                  for (final country in countries)
                    SizedBox(
                      width: width, height: 194,
                      child: CountryCard(
                        country: country,
                        onTap: () => widget.onOpenCountry(country),
                      ),
                    ),
                ],
              );
            }),
            const SizedBox(height: 34),
            const _SectionHeading(
              title: 'Must-see places',
              subtitle: 'Iconic stops worth the journey',
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 253,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: countries.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final place = countries[index].places.first;
                  return SizedBox(
                    width: 220,
                    child: FeaturedPlaceCard(
                      place: place,
                      onTap: () => widget.onOpenPlace(place),
                    ),
                  );
                },
              ),
            ),
          ] else ...[
            Text('Search results', style: Theme.of(context)
                .textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800,
                    color: _ink)),
            const SizedBox(height: 15),
            if (countryMatches.isEmpty && placeMatches.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 35),
                child: Center(
                  child: Text('No destinations found. Try another search.',
                      style: TextStyle(color: _muted)),
                ),
              ),
            for (final country in countryMatches)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DestinationRow(
                  title: country.name,
                  subtitle: country.region,
                  image: country.image,
                  onTap: () => widget.onOpenCountry(country),
                ),
              ),
            for (final place in placeMatches)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DestinationRow(
                  title: place.name,
                  subtitle: '${place.location}, ${countryForPlace(place).name}',
                  image: place.image,
                  onTap: () => widget.onOpenPlace(place),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class SavedPage extends StatelessWidget {
  const SavedPage({
    required this.savedPlaces,
    required this.onOpenPlace,
    required this.onExplore,
    super.key,
  });
  final List<TravelPlace> savedPlaces;
  final ValueChanged<TravelPlace> onOpenPlace;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(22, 28, 22, 35),
        children: [
          const Text('Your collection',
              style: TextStyle(color: _teal, fontSize: 12,
                  fontWeight: FontWeight.w900, letterSpacing: 2)),
          const SizedBox(height: 7),
          const Text('Saved places', style: TextStyle(
              fontSize: 34, color: _ink, fontWeight: FontWeight.w900)),
          const SizedBox(height: 9),
          const Text('Keep the places you dream of visiting in one spot.',
              style: TextStyle(color: _muted, height: 1.5)),
          const SizedBox(height: 30),
          if (savedPlaces.isEmpty) ...[
            const SizedBox(height: 68),
            const Icon(Icons.bookmark_add_outlined, size: 76, color: _teal),
            const SizedBox(height: 18),
            const Center(child: Text('No saved places yet',
                style: TextStyle(fontSize: 21,
                    fontWeight: FontWeight.w800, color: _ink))),
            const SizedBox(height: 9),
            const Center(child: Text(
                'Tap the bookmark on a destination to save it.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _muted))),
            const SizedBox(height: 23),
            FilledButton(
              onPressed: onExplore,
              style: FilledButton.styleFrom(
                backgroundColor: _teal,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('Explore destinations'),
            ),
          ] else
            for (final place in savedPlaces)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DestinationRow(
                  title: place.name,
                  subtitle: '${place.location}, ${countryForPlace(place).name}',
                  image: place.image,
                  onTap: () => onOpenPlace(place),
                ),
              ),
        ],
      ),
    );
  }
}

class CountryPage extends StatelessWidget {
  const CountryPage({
    required this.country,
    required this.onOpenPlace,
    super.key,
  });
  final TravelCountry country;
  final ValueChanged<TravelPlace> onOpenPlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: _teal,
            foregroundColor: Colors.white,
            expandedHeight: 350,
            pinned: true,
            title: Text(country.name),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(fit: StackFit.expand, children: [
                TravelPhoto(url: country.image),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x58071F30), Color(0xD9092536)],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 25, left: 24, right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Badge(text: country.region.toUpperCase(), color: _orange),
                      const SizedBox(height: 13),
                      Text(country.headline,
                          style: const TextStyle(color: Colors.white,
                              fontSize: 27, fontWeight: FontWeight.w900,
                              height: 1.15)),
                      const SizedBox(height: 7),
                      Text('${country.places.length} curated places to explore',
                          style: const TextStyle(color: Colors.white70,
                              fontSize: 13)),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 27, 22, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(country.description,
                      style: const TextStyle(color: _ink,
                          fontSize: 15.5, height: 1.7)),
                  const SizedBox(height: 22),
                  _CountryFacts(country: country),
                  const SizedBox(height: 30),
                  const _SectionHeading(
                    title: 'Famous places',
                    subtitle: 'Discover the best of this destination',
                  ),
                  const SizedBox(height: 16),
                  for (final place in country.places)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: DestinationRow(
                        title: place.name,
                        subtitle: '${place.location}  ·  ${place.category}',
                        image: place.image,
                        onTap: () => onOpenPlace(place),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlacePage extends StatefulWidget {
  const PlacePage({
    required this.place,
    required this.country,
    required this.initiallySaved,
    required this.onToggleSaved,
    super.key,
  });
  final TravelPlace place;
  final TravelCountry country;
  final bool initiallySaved;
  final VoidCallback onToggleSaved;

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  late bool _saved;

  @override
  void initState() {
    super.initState();
    _saved = widget.initiallySaved;
  }

  void _toggle() {
    setState(() => _saved = !_saved);
    widget.onToggleSaved();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(_saved ? 'Added to saved places' : 'Removed from saved places'),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final place = widget.place;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: _teal,
            foregroundColor: Colors.white,
            expandedHeight: 385,
            pinned: true,
            title: Text(place.name),
            actions: [
              IconButton(
                tooltip: _saved ? 'Remove from saved' : 'Save place',
                icon: Icon(_saved ? Icons.bookmark : Icons.bookmark_border),
                onPressed: _toggle,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(fit: StackFit.expand, children: [
                Hero(
                  tag: 'place-${place.id}',
                  child: TravelPhoto(url: place.image),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x33000000), Color(0xD9122A33)],
                    ),
                  ),
                ),
                Positioned(
                  left: 24, right: 24, bottom: 29,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Badge(text: place.category.toUpperCase(), color: _orange),
                      const SizedBox(height: 13),
                      Text(place.name, style: const TextStyle(
                          color: Colors.white, fontSize: 34,
                          fontWeight: FontWeight.w900, height: 1.08)),
                      const SizedBox(height: 9),
                      Row(children: [
                        const Icon(Icons.location_on_outlined,
                            color: Colors.white, size: 18),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text('${place.location}, ${widget.country.name}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)),
                        ),
                      ]),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(23, 25, 23, 44),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('WHY YOU’LL LOVE IT',
                      style: TextStyle(color: _teal, fontSize: 11,
                          fontWeight: FontWeight.w900, letterSpacing: 2.1)),
                  const SizedBox(height: 10),
                  Text(place.description,
                      style: const TextStyle(fontSize: 16,
                          height: 1.72, color: _ink)),
                  const SizedBox(height: 28),
                  Row(children: [
                    Expanded(child: _FactCard(
                      icon: Icons.wb_sunny_outlined,
                      title: 'Best time',
                      value: place.bestTime,
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: _FactCard(
                      icon: Icons.schedule_outlined,
                      title: 'Suggested visit',
                      value: place.duration,
                    )),
                  ]),
                  const SizedBox(height: 31),
                  const Text('The highlights',
                      style: TextStyle(color: _ink, fontSize: 23,
                          fontWeight: FontWeight.w900)),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 9, runSpacing: 9,
                    children: [
                      for (final highlight in place.highlights)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0xFFE7EDE8)),
                          ),
                          child: Text(highlight, style: const TextStyle(
                              color: _ink, fontSize: 12.5,
                              fontWeight: FontWeight.w600)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: _ink,
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(children: [
                          Icon(Icons.tips_and_updates_outlined,
                              color: _orange, size: 22),
                          SizedBox(width: 9),
                          Text('LOCAL TRAVEL TIP',
                              style: TextStyle(color: _orange,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 11, letterSpacing: 1.8)),
                        ]),
                        const SizedBox(height: 14),
                        Text(place.insiderTip,
                            style: const TextStyle(color: Colors.white,
                                fontSize: 14.5, height: 1.65)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Travel information is for inspiration. Always verify opening hours, tickets, local regulations and conditions before your trip.',
                    style: TextStyle(color: _muted, fontSize: 11.5,
                        height: 1.55),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountryFacts extends StatelessWidget {
  const _CountryFacts({required this.country});
  final TravelCountry country;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(children: [
        _FactLine(icon: Icons.sunny_snowing, label: 'When to visit',
            value: country.bestSeason),
        const Divider(height: 23),
        _FactLine(icon: Icons.translate, label: 'Language',
            value: country.language),
        const Divider(height: 23),
        _FactLine(icon: Icons.payments_outlined, label: 'Currency',
            value: country.currency),
      ]),
    );
  }
}

class _FactLine extends StatelessWidget {
  const _FactLine({required this.icon, required this.label,
      required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(children: [
    Icon(icon, color: _teal, size: 21),
    const SizedBox(width: 12),
    Text(label, style: const TextStyle(
        color: _muted, fontSize: 12)),
    const SizedBox(width: 9),
    Expanded(child: Text(value, textAlign: TextAlign.end,
        style: const TextStyle(color: _ink, fontSize: 12.5,
            fontWeight: FontWeight.w700))),
  ]);
}

class _FactCard extends StatelessWidget {
  const _FactCard({required this.icon, required this.title,
      required this.value});
  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(minHeight: 125),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(19),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _teal),
        const SizedBox(height: 11),
        Text(title, style: const TextStyle(
            color: _muted, fontSize: 11.5)),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(
            color: _ink, fontSize: 13,
            fontWeight: FontWeight.w800)),
      ],
    ),
  );
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(
          fontSize: 23, color: _ink, fontWeight: FontWeight.w900,
          letterSpacing: -0.5)),
      const SizedBox(height: 5),
      Text(subtitle, style: const TextStyle(
          color: _muted, fontSize: 12.5)),
    ],
  );
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
    decoration: BoxDecoration(
      color: color, borderRadius: BorderRadius.circular(20),
    ),
    child: Text(text, style: const TextStyle(
        color: _ink, fontWeight: FontWeight.w900,
        fontSize: 10, letterSpacing: 1.2)),
  );
}

class CountryCard extends StatelessWidget {
  const CountryCard({required this.country, required this.onTap, super.key});
  final TravelCountry country;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Material(
      color: _ink,
      child: InkWell(
        onTap: onTap,
        child: Stack(fit: StackFit.expand, children: [
          TravelPhoto(url: country.image),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xDA0B1D2A)],
              ),
            ),
          ),
          Positioned(
            left: 15, right: 11, bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(country.region.toUpperCase(),
                    style: const TextStyle(
                        color: _orange, fontSize: 9,
                        fontWeight: FontWeight.w900, letterSpacing: 1.6)),
                const SizedBox(height: 5),
                Text(country.name,
                    maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          const Positioned(
            top: 13, right: 12,
            child: Icon(Icons.arrow_outward, color: Colors.white, size: 19),
          ),
        ]),
      ),
    ),
  );
}

class FeaturedPlaceCard extends StatelessWidget {
  const FeaturedPlaceCard({required this.place, required this.onTap, super.key});
  final TravelPlace place;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: SizedBox(
              width: double.infinity, height: 155,
              child: Hero(
                tag: 'place-${place.id}',
                child: TravelPhoto(url: place.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 12, 13, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.category.toUpperCase(), style: const TextStyle(
                    color: _teal, letterSpacing: 1.2, fontSize: 9,
                    fontWeight: FontWeight.w900)),
                const SizedBox(height: 5),
                Text(place.name, maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16,
                        color: _ink, fontWeight: FontWeight.w900)),
                const SizedBox(height: 6),
                Text(place.location, style: const TextStyle(
                    fontSize: 12, color: _muted)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class DestinationRow extends StatelessWidget {
  const DestinationRow({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
    super.key,
  });
  final String title;
  final String subtitle;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(19),
    child: InkWell(
      borderRadius: BorderRadius.circular(19),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: SizedBox(
              height: 94, width: 104,
              child: TravelPhoto(url: image),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: _ink,
                        fontSize: 16, fontWeight: FontWeight.w800)),
                const SizedBox(height: 7),
                Text(subtitle,
                    maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: _muted,
                        fontSize: 12, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(width: 5),
          const Icon(Icons.chevron_right, color: _teal),
        ]),
      ),
    ),
  );
}

class TravelPhoto extends StatelessWidget {
  const TravelPhoto({required this.url, super.key});
  final String url;

  @override
  Widget build(BuildContext context) => Image.network(
    url,
    fit: BoxFit.cover,
    errorBuilder: (_, __, ___) => const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2C7D8B), Color(0xFF143C58)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(Icons.landscape_outlined,
            size: 55, color: Colors.white70),
      ),
    ),
  );
}
