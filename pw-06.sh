#   1. Inserting the Orders
db.commandes.insertMany([
  {
    client: "Alice",
    produit: "Laptop",
    quantité: 1,
    prix_unitaire: 1200,
    date: ISODate("2023-09-15")
  },
  {
    client: "Bob",
    produit: "Souris",
    quantité: 2,
    prix_unitaire: 25,
    date: ISODate("2025-09-16")
  },
  {
    client: "Alice",
    produit: "Clavier",
    quantité: 1,
    prix_unitaire: 50,
    date: ISODate("2025-09-17")
  }
]);


#   2. Adding the Field total
db.commandes.updateMany(
  {},
  [
    { $set: { total: { $multiply: ["$quantité", "$prix_unitaire"] } } }
  ]
);

#   3. Total Sales per Client
db.commandes.aggregate([
  { $group: { _id: "$client", total_ventes: { $sum: "$total" } } }
]);

#   4. Most Sold Product (by Quantity)
db.commandes.aggregate([
  { $group: { _id: "$produit", total_quantité: { $sum: "$quantité" } } },
  { $sort: { total_quantité: -1 } },
  { $limit: 1 }
]);

#   5. Creating an Index on the Field client
db.commandes.createIndex({ client: 1 });


#   6. Displaying Orders from September 2025
db.commandes.find({
  date: {
    $gte: ISODate("2025-09-01"),
    $lte: ISODate("2025-09-30")
  }
});


#   7. Updating the Price of the “Souris” Product
db.commandes.updateMany(
  { produit: "Souris" },
  {
    $set: {
      prix_unitaire: 30,
      total: { $multiply: ["$quantité", 30] }
    }
  }
);

#   8. Deleting Orders with Quantity < 2
db.commandes.deleteMany({ quantité: { $lt: 2 } });




