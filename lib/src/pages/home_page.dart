import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/productos_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productosBloc = Provider.procutosBloc(context);
    productosBloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
      title: Text('Home Page'),
      ),
      body: _crearListado(productosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(ProductosBloc productosBloc){

    return StreamBuilder(
      stream: productosBloc.productosStream ,
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if (snapshot.hasData) {

          final productos = snapshot.data;

          return ListView.builder(
            
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, productos[i], productosBloc)
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto, ProductosBloc productosBloc){

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: ( direccion ) => productosBloc.borrarProducto(producto.id),
      //productosProvider.borrarProducto(producto.id);
      child: Card(
        child: Column(
          children: <Widget>[
            ( producto.fotoUrl == null)
            ? Image(image: AssetImage('assets/no-image.png'),)
            : FadeInImage(
              image: NetworkImage( producto.fotoUrl ),
              placeholder: AssetImage('assets/jar-loading.gif'),
              height: 300.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text('${producto.titulo} - ${producto.valor}'),
              subtitle: Text(producto.id),
              onTap:  () => Navigator.pushNamed(context, 'producto', arguments: producto),
            ),
          ],
        ),
      )
    );
    

  }

  /*/*
  */ */

  _crearBoton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }

 
}