import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopmart_users/providers/wishlist_provider.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget({super.key, this.bkgColor = Colors.transparent, this.size = 20,
    required this.productId});
  final Color bkgColor;
  final double size;
  final String productId;
  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: widget.bkgColor,
          shape: BoxShape.circle
      ),
      child: IconButton(
        style: IconButton.styleFrom(
            elevation: 10
        ),
        onPressed: (){
        wishlistProvider.addOrRemoveFromWishlist(productId: widget.productId);
        },
        icon: Icon(
          wishlistProvider.isProdinWishlist(productId: widget.productId)
          ? IconlyBold.heart
          : IconlyLight.heart,
      size: widget.size,
          color: wishlistProvider.isProdinWishlist(productId: widget.productId)
            ?Colors.red
              :Colors.grey
      ),
      ),
    );
  }
}
