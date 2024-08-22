import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/product_bloc.dart';
import '../../bloc/product_event.dart';
import '../../bloc/product_state.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: homeBuilder(context, constraints),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.indigoAccent.shade400,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

Widget homeBuilder(BuildContext context, BoxConstraints constraints) {
  context.read<ProductBloc>().add(LoadProduct());

  final bool isWide = constraints.maxWidth > 600;

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Available Products',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/search');
              },
              splashColor: Colors.grey.shade300,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search_outlined,
                  color: Colors.black45,
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          final successState = state;
          return Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<ProductBloc>().add(LoadProduct());
              },
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWide ? 3 : 1, // Adapt grid to screen size
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: isWide ? 1 : 1.3, // Adjust aspect ratio
                ),
                itemCount: successState.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(
                    product: successState.products[index],
                  );
                },
              ),
            ),
          );
        } else {
          return const Center(child: Text('Error loading products'));
        }
      }),
    ],
  );
}
