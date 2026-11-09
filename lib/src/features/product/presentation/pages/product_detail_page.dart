import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/product/presentation/presentation.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  static const String routePath = "/product/:id";
  static const String idParam = "id";

  static String pathFor(String id) => "/product/${Uri.encodeComponent(id)}";

  static const _fadeHeight = 64.0;
  static const _bottomBarClearance = 144.0;
  static const _leadingWidth = 56.0;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailCubit>();
    final state = context.watch<ProductDetailCubit>().state;
    final product = state.product;
    final preview = state.preview;
    final background = context.theme.scaffoldBackgroundColor;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        leadingWidth: _leadingWidth,
        leading: const Align(
          alignment: Alignment.centerRight,
          child: StyledBackButton(),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.all(
            AppInsets.md,
          ).copyWith(bottom: _bottomBarClearance),
          children: [
            ProductInfoCard(
              code: product?.code ?? preview?.code,
              name: product?.name ?? preview?.name,
              priceMmk: state.unitPriceMmk,
              isNew: product?.isNew ?? preview?.isNew ?? false,
              imageUrl: product?.imageUrl ?? preview?.imageUrl,
              imageAspectRatio:
                  product?.imageAspectRatio ?? preview?.imageAspectRatio ?? 1,
              heroTag: preview?.heroTag ?? "product-$productId",
              stepper: QuantityStepper(
                quantity: state.quantity,
                canDecrement: state.quantity > ProductDetailCubit.minQuantity,
                canIncrement: state.quantity < ProductDetailCubit.maxQuantity,
                onDecrement: cubit.decrement,
                onIncrement: cubit.increment,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ProductDescription(
              description: product?.description,
              hasFailed: state.failure != null,
              onRetry: cubit.retry,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IgnorePointer(
            child: Container(
              height: _fadeHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [background, background.withValues(alpha: 0)],
                ),
              ),
            ),
          ),
          ColoredBox(
            color: background,
            child: AddToCartBar(
              totalMmk: state.totalMmk,
              onTap: () async {
                if (!await cubit.addToCart() || !context.mounted) return;
                final router = GoRouter.of(context);
                router.canPop() ? router.pop() : router.go("/");
              },
            ),
          ),
        ],
      ),
    );
  }
}
